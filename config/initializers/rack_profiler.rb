# frozen_string_literal: true

if Rails.env.development?
  require "rack-mini-profiler"

  # initialization is skipped so trigger it
  Rack::MiniProfiler.config.storage = Rack::MiniProfiler::MemoryStore
end
