#Creates a output log for you to view previously run cron jobs
set :output, "log/cron.log"

#Sets the environment to run during development mode (Set to production by default)
set :environment, "development"

every 5.minutes do
  rake "rake pghero:capture_query_stats"
end

every 1.day do
  rake "rake pghero:capture_space_stats"
end

# Learn more: http://github.com/javan/whenever
