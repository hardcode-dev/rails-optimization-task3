# frozen_string_literal: true
require 'rails_helper'
#
describe TripsController, type: :controller do
  context "with render views" do
    render_views
    describe "GET index" do
      before do
        Jobs::Import::TripsJob.new('fixtures/example.json').call
      end
      it "renders the actual template" do
        get :index, params: {from: 'Самара', to: 'Москва'}
        expect(response.body).to match /Автобусы Самара – Москва/
        expect(response.body).to match /В расписании 5 рейсов/

        expect(response.body).to match /Отправление: 17:30/
        expect(response.body).to match /Прибытие: 18:07/
        expect(response.body).to match /В пути: 0ч. 37мин./
        expect(response.body).to match /Цена: 1р. 73коп./
        expect(response.body).to match /Автобус: Икарус №123/

        expect(response.body).to match /Сервисы в автобусе:/
        expect(response.body).to match /Туалет/
        expect(response.body).to match /WiFi/
        
      end
    end
  end
end
