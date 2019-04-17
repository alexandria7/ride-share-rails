Rails.application.routes.draw do
  root 'drivers#index'
  resources :trips, except: %i[index new]
  resources :drivers
  resources :passengers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
