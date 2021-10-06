every 1.minutes do
  rake 'pghero:capture_query_stats'
end 