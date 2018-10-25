# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'home#index'
  get '/about', to: 'home#about'
  get '/help', to: 'home#help'

  post '/weights/create_from_rfid', to: 'weights#create_from_rfid',
                                    as: :weights_create_from_rfid
  get '/reports', to: 'reports#index', as: :reports_index
  get '/reports/drivers'
  get '/reports/trucks'
  post '/reports/driver_report', to: 'reports#drivers_report',
                                 as: :drivers_report
  post '/reports/truck_report', to: 'reports#trucks_report',
                                as: :trucks_report
  get 'trucks/by_license', as: :truck_by_license
end
