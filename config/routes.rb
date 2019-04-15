Rails.application.routes.draw do
  get 'passengers/index'
  get 'passengers/show'
  get 'passengers/edit'
  get 'passengers/update'
  get 'passengers/new'
  get 'passengers/create'
  get 'passengers/destroy'
  get 'trips/show'
  get 'trips/edit'
  get 'trips/update'
  get 'trips/create'
  get 'trips/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
