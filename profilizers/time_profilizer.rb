class TimeProfilizer
  def self.run(file_name, without_db_queries = false)
    RubyProf.measure_mode = RubyProf::WALL_TIME

    result = RubyProf.profile do
      ReloadJson.new.call(file_name, without_db_queries)
    end

    printer = RubyProf::CallTreePrinter.new(result)
    printer.print(:path => "profilizers/ruby_prof_reports", :profile => 'callgrind')
  end
end
