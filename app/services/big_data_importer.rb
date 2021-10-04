# frozen_string_literal: true

class BigDataImporter
  def self.call(file_name)
    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')

      File.open(file_name) { |f| Oj.saj_parse(TripsSaj.new, f) }
    end
  end
end
