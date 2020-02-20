Rails.application.routes.draw do
  mount PgHero::Engine, at: "pghero"

  get "/" => "statistics#index"
  get "автобусы/:from/:to" => "trips#index"
end
