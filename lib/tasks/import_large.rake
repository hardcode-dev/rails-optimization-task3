namespace :import do
  desc 'Imports json files into database'
  task :json_file, [:file_name] => :environment do |_task, args|
    puts "\n== Preparing database =="
    system 'bin/rails db:setup'

    puts "\n== Loading data from #{args.file_name} =="
    ImportService.new(args.file_name).call
  end
end
