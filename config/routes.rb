Rails.application.routes.draw do
  devise_for :users,
             path: '',
             path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 registration: 'signup'
             },
             controllers: {
                 sessions: 'sessions',
                 registrations: 'registrations'
             }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/health', to: 'application#health'

  post '/oauth/ppg', to: 'application#new_oauth_session'

  namespace :api do
    namespace :v1 do
      # Base controller
      get '/test', to: 'base_api#test'


      namespace :order do
        # Orders controller
        get '/', to: 'orders#index'
        post '/add_shippment', to: 'orders#add_shippment'
        get '/get_order_shippment', to: 'orders#get_order_shippment'
      end
    end
  end

end
