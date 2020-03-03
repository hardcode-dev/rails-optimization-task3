Rails.application.routes.draw do
  get "/" => "statistics#index"
  get "автобусы/:from/:to" => "trips#index"
end
