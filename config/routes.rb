Naturesoft::Core::Engine.routes.draw do
  devise_for :users, class_name: "Naturesoft::User", module: :devise
  namespace :admin do
    get '/' => 'admin#index'
    get '/dashboard' => 'dashboard#index', as: :dashboard
    resources :users do
      collection do
        match '/account' => 'users#account', :as => 'account', via: [:get, :patch, :put]
      end
    end
    
    # Setting
    match '/settings' => 'options#index', as: :options, via: [:get, :post]
  end
end