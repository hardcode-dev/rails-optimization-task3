Rails.application.routes.draw do
  get "/" => "statistics#index"
  get "автобусы/:from/:to" => "trips#index", as: 'trips'

  mount PgHero::Engine, at: "pghero"
end
