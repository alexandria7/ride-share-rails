Rails.application.routes.draw do

  root "trips#index"

  resources :trips, :drivers, :passengers

  resources :drivers do
    resources :trips, only: [:index, :new]
  end

  resources :passengers do
    resources :trips, only: [:index, :new]
  end

  post "/passengers/:passenger_id/trips/", to: 'trips#create', as: 'create_passenger_trip'
end
