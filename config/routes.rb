# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  root to: 'home#index'
  get '/about', to: 'home#about'
  get '/help', to: 'home#help'

  post '/weights/create_from_rfid',
       to: 'weights#create_from_rfid',
       as: :weights_create_from_rfid
  ActiveAdmin.routes(self)
end
