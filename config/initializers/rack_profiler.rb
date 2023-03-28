# frozen_string_literal: true

if Rails.env.development?
  require 'rack-mini-profiler'

  # initialization is skipped so trigger it
  Rack::MiniProfiler.config.show_total_sql_count = true
  Rack::MiniProfilerRails.initialize!(Rails.application)
end
