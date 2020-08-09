require 'rails_helper'

RSpec.describe ReloadJson, type: :service do
  let(:file_name) { "#{Rails.root}/fixtures/example.json" }

  it 'Обработка выполняется не более 100 мс' do
    expect do
      described_class.call(file_name)
    end.to perform_under(100).ms.warmup(2).times.sample(2).times
  end
end
