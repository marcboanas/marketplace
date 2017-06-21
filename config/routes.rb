Rails.application.routes.draw do
  resources :messages
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'help', to: 'static_pages#help', as: 'faq'
  get 'about', to: 'static_pages#about'
  get '/signup', to: 'users#new'
  root 'static_pages#home'
end
