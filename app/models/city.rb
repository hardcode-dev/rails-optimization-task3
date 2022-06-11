# == Schema Information
#
# Table name: cities
#
#  id   :bigint           not null, primary key
#  name :string
#
class City < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validate :name_has_no_spaces

  has_many :trip_from, class_name: 'Trip', foreign_key: :from_id
  has_many :trip_to, class_name: 'Trip', foreign_key: :to_id

  def name_has_no_spaces
    errors.add(:name, "has spaces") if name.include?(' ')
  end
end
