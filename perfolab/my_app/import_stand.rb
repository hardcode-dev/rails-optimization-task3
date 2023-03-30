# frozen_string_literal: true

require 'my_app/import'
require 'perfolab'

loop =
  PerfoLab::Loop.new do |toolbox|
    toolbox.add_tool(
      :stackprof,
      type: :stackprof,
      config: {
        raw: true
      },
      runner_options: {
        arguments: ['small']
      }
    )
    toolbox.add_tool(
      :benchmark,
      type: :benchmark,
      runner_options: {
        warmup: 1,
        arguments: [
          'small',
          # 'medium',
          # 'large'
        ]
      }
    )
  end

loop.analyze do |filename|
  MyApp::Import.new(Rails.root.join('fixtures', "#{filename}.json")).call
end
