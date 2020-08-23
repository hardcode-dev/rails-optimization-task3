# == Schema Information
#
# Table name: trips
#
#  id               :bigint           not null, primary key
#  from_id          :integer
#  to_id            :integer
#  start_time       :string
#  duration_minutes :integer
#  price_cents      :integer
#  bus_id           :integer
#

class Trip < ApplicationRecord
  HHMM_REGEXP = /([0-1][0-9]|[2][0-3]):[0-5][0-9]/

  belongs_to :from, class_name: 'City'
  belongs_to :to, class_name: 'City'
  belongs_to :bus

  validates :from, presence: true
  validates :to, presence: true
  validates :bus, presence: true

  validates :start_time, format: { with: HHMM_REGEXP, message: 'Invalid time' }
  validates :duration_minutes, presence: true
  validates :duration_minutes, numericality: { greater_than: 0 }
  validates :price_cents, presence: true
  validates :price_cents, numericality: { greater_than: 0 }

  def to_h
    {
      from: from.name,
      to: to.name,
      start_time: start_time,
      duration_minutes: duration_minutes,
      price_cents: price_cents,
      bus: {
        number: bus.number,
        model: bus.model,
        services: bus.services.map(&:name),
      },
    }
  end
end
