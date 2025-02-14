# frozen_string_literal: true

require 'profiler'

namespace :reports do
  task :build, [:reporter_type] => :environment do |_t, args|
    reporter_type = args.reporter_type

    available_types = %w[
      memory_prof
      stack_prof
      ruby_prof
    ]

    abort "unknow profiler type: #{reporter_type}" unless available_types.include?(reporter_type)

    Profiler.make_report(reporter_type)
  end
end
