Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount PgHero::Engine, at: "pghero"
  get "/" => "statistics#index"
  get "автобусы/:from/:to" => "trips#index"
end
