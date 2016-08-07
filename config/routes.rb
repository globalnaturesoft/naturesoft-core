Naturesoft::Core::Engine.routes.draw do
  devise_for :users, class_name: "Naturesoft::User", module: :devise
  root to: "home#index"
  namespace :admin do
    get '/' => 'admin#index'
    get '/dashboard' => 'dashboard#index', as: :dashboard
    resources :users
  end
end