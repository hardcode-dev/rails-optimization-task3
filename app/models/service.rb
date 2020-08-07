class Service < ApplicationRecord
  SERVICES = [
    'WiFi',
    'Туалет',
    'Работающий туалет',
    'Ремни безопасности',
    'Кондиционер общий',
    'Кондиционер Индивидуальный',
    'Телевизор общий',
    'Телевизор индивидуальный',
    'Стюардесса',
    'Можно не печатать билет',
  ].freeze

  has_and_belongs_to_many :buses, join_table: :buses_services

  validates :name, presence: true
  validates :name, inclusion: { in: SERVICES }

  def self.find_dumped(names)
    @all_dumped ||= dump_all_to_db
    @all_dumped.slice(*names).values
  end

  private

  def self.dump_all_to_db
    SERVICES.sort.reverse.each do |name|
      Service.find_or_create_by!(name: name)
    end
    Service.all.map{ |s| [s.name, s]}.to_h
  end
end
