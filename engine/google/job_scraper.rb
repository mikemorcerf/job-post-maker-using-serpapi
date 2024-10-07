module Engine
  module Google
    class JobScraper
      @job_list_file_path = File.expand_path('../../GENERATED_JOB_LIST.txt', __dir__)

      class << self
        attr_reader :job_list_file_path
      end

      def initialize(
        job_title: nil,
        location: nil,
        remote: nil,
        language_code: 'en',
        number_of_jobs: 15,
        fun_bullet_point: '🟢',
        board_relevance: []
      )
        raise ArgumentError, "Parameter `job_title` is required." if job_title.nil? || job_title.strip.empty?

        @q = job_title
        @location = location
        @ltype = get_remote_code(remote)
        @hl = language_code
        @number_of_jobs = number_of_jobs
        @fun_bullet_point = fun_bullet_point
        @board_relevance = board_relevance
        @job_boards_covered = []
      end

      def generate_job_list
        response = get_jobs

        File.open(self.class.job_list_file_path, 'w') do |file|
          response.each do |job|
            file.puts "#{@fun_bullet_point} #{job[:title]} at @#{job[:company]}: #{job[:link]}"
          end
        end

        puts "COMPLETED: #{response.length} jobs added to the list.\n\n"

        @job_boards_covered.sort_by! { |job_board| job_board.downcase }
        puts 'Job boards covered:'
        @job_boards_covered.each do |job_board|
          puts job_board
        end
      end

      def get_jobs
        response = []
        next_page_token = nil
        current_number_of_jobs = 0
        total_number_of_jobs = 0

        puts 'Starting to scrape jobs'

        while response.length < @number_of_jobs
          current_response = get_page_result(next_page_token: next_page_token)

          break if current_response[:jobs_results].nil?
          total_number_of_jobs += current_response[:jobs_results].length

          current_response[:jobs_results].each do |result|
            break if response.length >= @number_of_jobs

            unless response.any? { |job| job[:title] == result[:title] && job[:company] == result[:company_name] }
              response << {
                title: result[:title],
                company: result[:company_name],
                link: get_url(result)
              }
            end
          end

          unless response.length == current_number_of_jobs
            puts "Scrapping... #{response.length} unique jobs out of #{total_number_of_jobs} jobs scrapped."
          end

          current_number_of_jobs = response.length
          break if current_response[:serpapi_pagination].nil?
          next_page_token = current_response[:serpapi_pagination][:next_page_token]
        end

        response.sort_by { |job| job[:title].downcase }
      end

      def get_page_result(next_page_token: nil)
        search = GoogleSearch.new(request_params(next_page_token: next_page_token))
        search.get_hash
      end

      def request_params(next_page_token: nil)
        params = {
          engine: 'google_jobs',          # specify which engine you want to scrape using SerpApi
          q: @q,                          # query you're requestig from the search engine
          hl: @hl,                        # language code for the language you want the results to be
          no_cache: true,                 # specify whether you want cached responses from SerpApi
          api_key: ENV['SERPAPI_API_KEY'] # SerpApi Secret API Key you need to use SerpApi
        }

        params.merge!(next_page_token: next_page_token) if next_page_token
        params.merge!(location: @location) if @location
        params.merge!(ltype: @ltype) if @ltype # specify whether you want jobs to be remote or not - you can omit this argument to get both remote and non-remote jobs in the response
        params
      end

      def get_url(result)
        sorted_links = sort_links_by_relevance(result[:apply_options])

        uri = URI.parse(sorted_links.first[:link])
        query_params = CGI.parse(uri.query.to_s)      
        filtered_params = query_params.reject { |key| key.start_with?('utm') }
        uri.query = URI.encode_www_form(filtered_params)

        uri.to_s
      end

      def board_relevance_normalized
        @board_relevance_normalized ||= @board_relevance.map do |board|
          board.downcase.gsub(/\s+/, '')
        end
      end

      def sort_links_by_relevance(apply_options)
        apply_options.sort_by do |option|
          next Float::INFINITY if option[:title].nil?
          @job_boards_covered << option[:title] unless @job_boards_covered.include?(option[:title])

          normalized_title = option[:title].downcase.gsub(/\s+/, '')
          board_relevance_normalized.index(normalized_title) || Float::INFINITY
        end
      end

      def get_remote_code(remote)
        case remote
        when true
          1
        when false
          0
        else
          nil
        end
      end
    end
  end
end
