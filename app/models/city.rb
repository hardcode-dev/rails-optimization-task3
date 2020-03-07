class City < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validate :name_has_no_spaces

  def name_has_no_spaces
    errors.add(:name, "has spaces") if name.include?(' ')
  end

  def self.find_cached_or_create(name)
    name = name.gsub(' ','')
    @all_cities ||= City.all.map{|city| [city.name, city]}.to_h
    @all_cities[name] ||= City.create!(name:name)
  end
end
