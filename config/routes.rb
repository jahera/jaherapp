Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {registrations: 'registrations', sessions: 'sessions' }

  resources :users, only: [:index] do
    get :profile, on: :collection
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
