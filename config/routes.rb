Naturesoft::Core::Engine.routes.draw do
  devise_for :users, class_name: "Naturesoft::User", module: :devise, :controllers => {:sessions => "naturesoft/users/sessions"}
  namespace :admin do
    get '/' => 'admin#index'
    get '/dashboard' => 'dashboard#index', as: :dashboard
    
    resources :users do
      collection do
        match '/account' => 'users#account', :as => 'account', via: [:get, :patch, :put]
      end
    end
    
    resources :user_groups do
      collection do
        delete "delete"
        get "select2"
      end
    end
    
    resources :nsmodules do
      collection do
        delete 'delete'
        get 'options'
        get 'sort'
      end
    end
    
    # Setting
    match '/settings/:engine' => 'options#index', as: :options, via: [:get, :post]
    match '/custom_sort/:class' => 'admin#custom_sort', as: :custom_sort, via: [:get]
  end
end