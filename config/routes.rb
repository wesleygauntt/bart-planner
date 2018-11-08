Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :trip, only: [:index, :create]

  root 'trip#index'

end
