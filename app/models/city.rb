# frozen_string_literal: true

class City < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validate :name_has_no_spaces
  has_many :to_trips, class_name: 'Trip', inverse_of: :from, foreign_key: :from_id
  has_many :from_trips, class_name: 'Trip', inverse_of: :to, foreign_key: :to_id


  def name_has_no_spaces
    errors.add(:name, 'has spaces') if name.include?(' ')
  end
end
