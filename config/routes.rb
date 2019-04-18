Rails.application.routes.draw do
  root to: "homepages#index"
  resources :homepages, only: [:index]
  resources :trips
  resources :drivers
  resources :passengers

  resources :passengers do
    resources :trips, only: %i[index new]
  end

  resources :drivers do
    resources :trips, only: %i[index new]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
