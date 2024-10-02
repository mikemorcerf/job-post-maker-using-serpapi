require_relative './setup'

# Signup to SerpApi to get your API Key
# and have access to 100 free searches per month
# Link: https://serpapi.com/users/sign_up?plan=free


# Job you would like to search for.
# Examples:
# 'Game developer'
# 'React developer full time'
# 'developer internship'
# 'Lead software engineer contract'
#
# Parameter Required
job_title = 'Ruby on Rails'


# Parameter defines from where you want the search to originate.
# If several locations match the location requested, we'll pick the most popular one.
# Head to the /locations.json API if you need more precise control.
# The location and uule parameters can't be used together.
# It is recommended to specify location at the city level in order to simulate a real user’s search.
# If location is omitted, the search may take on the location of the proxy.
# Documentation link: https://www.serpapi.com/google-jobs-api
# Link to download a list of Supported Locations: https://serpapi.com/locations.json
# Examples:
# 'Sao Paulo,State of Sao Paulo,Brazil'
# 'Mumbai,Maharashtra,India'
#
# Parameter Optional
location = 'New York,New York,United States'


# Parameter will filter the results by work from home.
# false = on-premise
# true = work from home
#
# Parameter Optional
remote = true


# Parameter defines the language to use for the Google Jobs search.
# It's a two-letter language code.
# Examples:
# 'en' for English
# 'es' for Spanish
# 'pt-br' for Portuguese
#
# Link to list of Supported Laguages: https://serpapi.com/google-languages
language_code = 'en'


# Google usually returns 10 results per page.
# You can increase the number of jobs retrieved, however,
# the greater the number, the greater will be the number
# of requests to retrieve them.
# Usually you can get 10 results per request.
number_of_jobs = 15


# If you have preferences for which job boards you'd like the links for the jobs to be from,
# you can list them here in order of relevance. If the job has a link from any of the job boards
# listed in this array, that link will be the one written on the list. If the job is not listed
# in any of the job board options listed in the array, then the script will just pick the first
# option it finds to write on the job list.
# The list below is for reference. Feel free to change it to include only the job boards you'd like.
board_relevance = [
  'LinkedIn',
  'GoRails Jobs',
  'Ruby On Remote',
  'We Are Hiring',
  'We Work Remotely'
]


fun_bullet_point = '🦖'


search_params = { job_title: job_title }
search_params.merge!(location: location) if defined?(location)
search_params.merge!(remote: remote) if defined?(remote)
search_params.merge!(language_code: language_code) if defined?(language_code)
search_params.merge!(number_of_jobs: number_of_jobs) if defined?(number_of_jobs)
search_params.merge!(fun_bullet_point: fun_bullet_point) if defined?(fun_bullet_point)
search_params.merge!(board_relevance: board_relevance) if defined?(board_relevance)


Engine::Google::JobScrapper.new(**search_params).generate_job_list


















Engine::Google::JobScrapper.new(
  job_title: job_title,
  location: location,
  remote: remote,
  language_code: language_code,
  number_of_jobs: number_of_jobs,
  fun_bullet_point: fun_bullet_point,
  board_relevance: board_relevance
).generate_job_list

