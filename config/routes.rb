Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "автобусы/:from/:to" => "trips#index"
  mount PgHero::Engine, at: "pghero" if Rails.env.development?
end
