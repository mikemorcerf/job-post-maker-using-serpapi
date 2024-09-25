# Make Job Board posts using [SerpAPI](https://serpapi.com/)

## 👋 Introduction

This project has a script file `job_post_maker.rb` that sets some parameters that are used to generate a list of jobs in the `GENERATED_JOB_LIST.txt` file:

- `job_title`: `Required parameter` The query used to find jobs using [SerpApi](https://github.com/serpapi/google-search-results-ruby)'s [Google Jobs API](https://serpapi.com/google-jobs-api).
\nValue Examples:
```
job_title = 'Ruby on Rails'
job_title = 'Game developer'
job_title = 'React developer full time'
job_title = 'developer internship'
job_title = 'Lead software engineer contract'
```

- `location`: `Optional parameter` Defines from where you want the search to originate. If several locations match the location requested, we'll pick the most popular one. [Download](https://serpapi.com/locations.json) a list of all supported locations.

- `remote`: `Optional parameter` Only fetches remote jobs when set to `true`, and only fetches on-premise jobs when set to `false`. If not included, the script will fetch both remote and on-premise jobs.

- `language_code`: `Optional parameter` Two-letter language code parameter that defines the language to use for the Google Jobs search. See a list of [Supported Laguages](https://serpapi.com/google-languages). If this parameter is not provided, then the default language code for English will be used.
\nValue Examples:
```
language_code = 'en' # for English
language_code = 'es' # for Spanish
language_code = 'pt-br' # for Portuguese
```

- `number_of_jobs`: `Optional parameter` Number of unique jobs to fetch for the job list. If not used, it will default to returning the jobs listed on the first page of job results. If the number provided is greater than the number of unique jobs available for your specific parameters, then the script will only return the number of jobs it can find.
\n`Attention:` The greater the number of jobs requested the more requests will be necessary to make the list. Usually, Google returns 10 jobs per request, but sometimes it returns less. Also, duplicate jobs are not added to the list. It's important to keep this in mind because [SerpApi](https://serpapi.com/pricing)'s Free tier offers 100 requests per month, so you may want to adjust this parameter based on how many times you'd like to create a job list per month, or you can consider upgrading your [SerpApi](https://serpapi.com/pricing) account to a paid tier.

- `board_relevance`: `Optional parameter` Array where you list your favorite job boards. Each job has options for links where to apply for that opportunity. If any of the available options are listed in this Array, then the link to apply for the job will be for the job board listed in the Array depending on the order listed. The first job boards listed have higher relevance. Also, every time you run the script, a list of all job boards associated with the jobs on the list will be printed on the terminal to make it easier to find job boards available and to make it easier to copy the names of job boards you like most.
\nValue Example:
```
board_relevance = [
  'LinkedIn',
  'GoRails Jobs',
  'Ruby On Remote',
  'We Are Hiring',
  'We Work Remotely'
]
```

- `fun_bullet_point`: `Optional parameter` The string provided in this parameter will be used as a bullet point when generating the job list. It's recommended to use an emoji to make the list look more appealing, fun and engaging. If this parameter is not provided, then the list will use the default 🟢 as a bullet point.


## Requirement

In order to use this script, you must [create a SerpApi account](https://serpapi.com/users/sign_up?plan=free) in order to get your [SerpApi Private API Key](https://serpapi.com/dashboard). The free tier grants you 100 free searches per month.
\nAfter you created your account, you must create a file named `.env` in the main directory (same directory where `job_post_maker.rb` file is).
\nThen you must paste your [SerpApi Private API Key](https://serpapi.com/dashboard) in that file, using the content of the file `.env_sample` as reference.
\nContent Example:
```
SERPAPI_API_KEY=your_SerpApi_private_API_key
```


## 🛠️ Setup

This project requires [ruby installed](https://www.ruby-lang.org/en/documentation/installation/) in order to run.

Install gems:
```
bundle install
```

Create an `.env` file in the main directory and copy and paste your API key there:

```
SERPAPI_API_KEY=your_SerpApi_private_API_key
```

Run the `job_post_maker.rb` script to make the script run:
```
ruby job_post_maker.rb
```


## 🙌 Output Sample
(Jobs scrapped September/25/2024 using the parameters pre-filled in the script)
\nList generated in `./GENERATED_JOB_LIST.txt`:
```
🦖 Backend/Full Stack developer – Ruby on Rails at @Cisco Meraki: https://rubyonremote.com/jobs/62925-backend-full-stack-developer-ruby-on-rails-at-cisco-meraki?
🦖 Full Stack Developer (Ruby Rails + ReactJS) at @Storylane: https://www.workatastartup.com/jobs/55767?
🦖 Full Stack Ruby on Rails Developer - 1822656 at @CADRE GOVERNMENT SOLUTIONS: https://www.simplyhired.com/job/SC0VMcWqtb2m30lXeFfKbIV-mKInEfVi4nAz9gZrozd8roWzWbEevA?
🦖 Full-Stack Ruby on Rails Developer at @DMI (Digital Management, LLC): https://www.linkedin.com/jobs/view/full-stack-ruby-on-rails-developer-at-dmi-digital-management-llc-3995753457?
🦖 Lead Ruby on Rails Developer at @Universal Technologies: https://www.linkedin.com/jobs/view/lead-ruby-on-rails-developer-at-universal-technologies-3988865168?
🦖 Lead Ruby on Rails Developer at @Elevato: https://www.glassdoor.com/job-listing/lead-ruby-on-rails-developer-elevato-JV_KO0,28_KE29,36.htm?jl=1009378945749
🦖 Remote Ruby on Rails Developer (From Chile, for US company) at @LatAm connex LLC: https://www.indeed.com/viewjob?jk=5212ce4a7d10d49e
🦖 Remote Ruby On Rails Job for Software Development Firm (Part-time) at @Toptal: https://www.toptal.com/freelance-jobs/developers/ruby-on-rails/senior-ruby-on-rails-engineer-184?
🦖 Remote: Frontend Ruby on Rails / Vue.js engineer at @Commslayer: https://rubyonremote.com/jobs/63640-remote-frontend-ruby-on-rails-vue-js-engineer-at-commslayer?
🦖 Ruby & Rails Developer at @Han Staffing: https://www.ziprecruiter.com/c/Han-Staffing/Job/Ruby-&-Rails-Developer/-in-Wayne,NJ?jid=bcd627a3d9c52dbc
🦖 Ruby on Rails at @Dellfor Technologies: https://jobs.smartrecruiters.com/DellforTechnologies/110898913-ruby-on-rails?
🦖 Ruby On Rails at @Amiga Informatics: https://www.publiremote.com/trabajos/aha-sr-ruby-on-rails-engineer-2/?
🦖 Ruby on Rails Consultant at @OptionMetrics: https://www.simplyhired.com/job/b6dJMJ61csUPKP_c5S4BsjmzF2us5JrZW6dZCdJUrIxNFSmfJt1qZQ?
🦖 Ruby on Rails Developer at @GearBooth, LLC: https://jobs.smartrecruiters.com/GearBoothLLC/82094782-back-end-developer-rails-?
🦖 Ruby on Rails Developer at @Resourznet Consulting: https://www.simplyhired.com/job/-fNyxL7f_mhwp84O45qslaKkFzfJvwOrRrES6xmSsZH3Few_Ponjzw?
🦖 Ruby on Rails developer at @Maintec Technologies Inc: https://www.dice.com/job-detail/c9fb6991-1e49-4fa2-aeab-ee2398e0ff38?
🦖 Ruby on Rails Developer (Fullstack) (3 openings) at @Vakula Technologies Inc: https://www.linkedin.com/jobs/view/ruby-on-rails-developer-fullstack-3-openings-at-vakula-technologies-inc-3960160658?
🦖 Ruby on Rails Engineer Summer Intern at @NinjaHoldings: https://rubyonremote.com/jobs/63766-ruby-on-rails-engineer-summer-intern-at-ninjaholdings?
🦖 Ruby on Rails full stack developer with strong front end coding skills at @Upwork: https://www.upwork.com/freelance-jobs/apply/Ruby-Rails-full-stack-developer-with-strong-front-end-coding-skills_~021837152205556141419/?
🦖 Senior Applications Developer- Ruby on Rails at @Intone: https://www.linkedin.com/jobs/view/senior-applications-developer-ruby-on-rails-at-intone-4031543194?
🦖 Senior Backend Engineer- Ruby on Rails at @Cast & Crew: https://careers.ta.com/companies/cast-crew/jobs/40724843-senior-backend-engineer-ruby-on-rails?
🦖 Senior Developer Ruby on Rails / Healthcare/ Remote at @Triunity Software: https://jooble.org/rjdp/-540527725731448120?
🦖 Senior Full Stack Developer Ruby on Rails at @Prevail Legal: https://rubyonremote.com/jobs/63422-senior-full-stack-developer-ruby-on-rails-at-prevail-legal?
🦖 Senior Full-Stack Software Engineer - Ruby-on-Rails-focused, Remote within the U.S. and Canada at @Cisco Meraki: https://www.linkedin.com/jobs/view/senior-full-stack-software-engineer-ruby-on-rails-focused-remote-within-the-u-s-and-canada-at-cisco-meraki-4034387195?
🦖 Senior Ruby on Rails Developer at @Sincere Corporation: https://www.linkedin.com/jobs/view/senior-ruby-on-rails-developer-at-sincere-corporation-3963722211?
🦖 Senior Ruby on Rails Engineer at @SquarePeg Hires: https://www.squarepeghires.com/jobs/p6d502/ruby-on-rails-developer?
🦖 Software Engineer (Ruby on Rails) at @Welcome Homes: https://www.builtinnyc.com/node/175882?
🦖 Software Engineer (Ruby/Rails) at @Red Canary: https://dailyremote.com/remote-job/software-engineer-ruby-rails-3176222?
🦖 Software Engineer - Ruby on Rails at @UserTesting: https://www.nowhiteboard.org/jobs/6481ed74e05308a6e9af98bd?
🦖 Sr. Ruby on Rails Developer at @The Cypress Group: https://www.theladders.com/job-listing/sr-ruby-on-rails-developer-the-cypress-group-new-york-ny-_v2_-7-331609830.html?
```

Output generated on the terminal:
```
Starting to scrape jobs
Scrapping... 9 unique jobs out of 10 jobs scrapped.
Scrapping... 19 unique jobs out of 20 jobs scrapped.
Scrapping... 28 unique jobs out of 29 jobs scrapped.
Scrapping... 30 unique jobs out of 39 jobs scrapped.
COMPLETED: 30 jobs added to the list.

Job boards covered:
Adzuna
BeBee
Built In Chicago
Built In NYC
Built In San Francisco
Built With Django
Careers At Integrated Resources, Inc
Coding Job Board
Companies | TA Associates Job Board - TA Associates
Curaiz
DailyRemote
Dice
FreshRemote.Work
Glassdoor
GrabJobs
HelloWorld.rs
Indeed
Jersey City - AmericanListed.com
Jobgether
Jobilize
JobMESH
Jobrapido.com
JobsCollider
Jooble
Ladders
LazyApply
Learn4Good
Lensa
LinkedIn
New York Jobs - Tarta.ai
No Whiteboard
Offered.AI
Publiremote.com
Recooty
Remote Rocketship
RemoteScout24
Ruby On Remote
Ruby-Forum
Sercanto
SimplyHired
Smart Recruiters Jobs
Snagajob
SquarePeg
Tarta.ai
Teaching Education
Techfetch
Toptal
Upwork
Washington DC Jobs
WhatJobs
Work At A Startup
ZipRecruiter
```