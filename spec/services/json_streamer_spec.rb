# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JsonStreamer do
  subject(:stream) { described_class.stream('fixtures/example.json') }

  it 'streams JSON objects' do
    expect(stream.to_a).to contain_exactly(
      { 'bus' => { 'model' => 'Икарус', 'number' => '123', 'services' => %w[Туалет WiFi] }, 'duration_minutes' => 168,
        'from' => 'Москва', 'price_cents' => 474, 'start_time' => '11:00', 'to' => 'Самара' },
      { 'bus' => { 'model' => 'Икарус', 'number' => '123', 'services' => %w[Туалет WiFi] }, 'duration_minutes' => 37,
        'from' => 'Самара', 'price_cents' => 173, 'start_time' => '17:30', 'to' => 'Москва' },
      { 'bus' => { 'model' => 'Икарус', 'number' => '123', 'services' => %w[Туалет WiFi] }, 'duration_minutes' => 323,
        'from' => 'Москва', 'price_cents' => 672, 'start_time' => '12:00', 'to' => 'Самара' },
      { 'bus' => { 'model' => 'Икарус', 'number' => '123', 'services' => %w[Туалет WiFi] }, 'duration_minutes' => 315,
        'from' => 'Самара', 'price_cents' => 969, 'start_time' => '18:30', 'to' => 'Москва' },
      { 'bus' => { 'model' => 'Икарус', 'number' => '123', 'services' => %w[Туалет WiFi] }, 'duration_minutes' => 304,
        'from' => 'Москва', 'price_cents' => 641, 'start_time' => '13:00', 'to' => 'Самара' },
      { 'bus' => { 'model' => 'Икарус', 'number' => '123', 'services' => %w[Туалет WiFi] }, 'duration_minutes' => 21,
        'from' => 'Самара', 'price_cents' => 663, 'start_time' => '19:30', 'to' => 'Москва' },
      { 'bus' => { 'model' => 'Икарус', 'number' => '123', 'services' => %w[Туалет WiFi] }, 'duration_minutes' => 598,
        'from' => 'Москва', 'price_cents' => 629, 'start_time' => '14:00', 'to' => 'Самара' },
      { 'bus' => { 'model' => 'Икарус', 'number' => '123', 'services' => %w[Туалет WiFi] }, 'duration_minutes' => 292,
        'from' => 'Самара', 'price_cents' => 22, 'start_time' => '20:30', 'to' => 'Москва' },
      { 'bus' => { 'model' => 'Икарус', 'number' => '123', 'services' => %w[Туалет WiFi] }, 'duration_minutes' => 127,
        'from' => 'Москва', 'price_cents' => 795, 'start_time' => '15:00', 'to' => 'Самара' },
      { 'bus' => { 'model' => 'Икарус', 'number' => '123', 'services' => %w[Туалет WiFi] }, 'duration_minutes' => 183,
        'from' => 'Самара', 'price_cents' => 846, 'start_time' => '21:30', 'to' => 'Москва' }
    )
  end
end
