class TripsContainer
  extend Dry::Container::Mixin

  register("import") do
    Trips::Import.new(
      Utils::TruncateTables.new,
      BusServices::Seed.new
    )
  end
end
