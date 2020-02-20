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

  def name_has_no_spaces
    errors.add(:name, "has spaces") if name.include?(' ')
  end
end
