class DatabaseCleanupService
  def self.call
    Trip.delete_all
    City.delete_all
    Bus.delete_all
    Service.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')
  end
end
