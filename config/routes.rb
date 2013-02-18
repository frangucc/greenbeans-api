Greenbean::Application.routes.draw do

  devise_for :merchants, :users


  namespace :merchant do
    get "reports/index"
    match 'reports' => "reports#index"
    match 'new_prize' => "prizes#new_prize"
    match 'create_prize' => "prizes#create_prize"
    match 'create' => "raffles#create"
    match 'rewards/create' => 'rewards#create'
    resources :actions
    resources :prizes
    resources :members
    resources :rewards
    root :to => 'reports#index'
  end

  namespace :api do
    get 'docs/index'
    match 'docs' => 'docs#index'
    match "/matrix/min_weigth" => "matrixs#min_weigth_path", :via  => :post

    namespace :merchant do
      resources :sessions, :only  => [:create] do
        collection do
          post :delete
        end
      end

      devise_scope :merchant do
        match 'registrations' => 'registrations#create'
        match 'passwords' => 'passwords#create'
      end
      resources :raffles, :only => [:create, :destroy, :update]
      resources :rewards, :only => [:create, :destroy, :update, :index, :show]



      resources :tokens, :only => [:create] do
        collection do
          get :beans
        end
      end
    end

    namespace :consumer do
      resources :sessions, :only  => [:create] do
        collection do
          post :delete
        end
      end

      devise_scope :user do
        match 'registrations' => 'registrations#create'
        match 'passwords' => 'passwords#create'
      end

      resources :beans do
        collection do
          get :validate
          get :my_beans
        end
      end
    end
  end

  root :to => 'api/docs#index'
end

