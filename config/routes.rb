# frozen_string_literal: true

Rails.application.routes.draw do
  # get '/' => 'statistics#index'
  get 'автобусы/:from/:to' => 'trips#index'

  mount PgHero::Engine, at: 'pghero'
end
