namespace :profile do

  desc "Run profiles cpu"
  task :cpu => :environment do |_task, args|
    StackProf.run(mode: :cpu, out: 'tmp/stackprof-cpu.dump') do
      Rake.application.invoke_task 'reload_json[fixtures/small.json]'
    end
  end

  desc "Run profiles rss"
  task :rss => :environment do |_task, args|
    StackProf.run(mode: :object, out: 'tmp/stackprof-rss.dump', raw: true) do
      Rake.application.invoke_task 'reload_json[fixtures/small.json]'
    end
  end
end
