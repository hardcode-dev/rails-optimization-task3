Rails.application.routes.draw do
  mount PgHero::Engine, at: "pghero"

  get "/" => "trips#index", defaults: { from: 'Самара', to: 'Москва' }
  get "автобусы/:from/:to" => "trips#index"
end
