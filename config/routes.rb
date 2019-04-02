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

      namespace :cars do
        get '/:vin', to: 'cars#show'
      end

      namespace :order do
        # Orders
        get '/', to: 'orders#show'
        post '/create_shippment', to: 'orders#create_shippment'
      end

      namespace :shipper do
        # Shippers
        get '/', to: 'shippers#show'
        post '/', to: 'shippers#create'
      end

      namespace :shippment do
        # Shippments
        get '/', to: 'shippments#show'
        get '/:order_number', to: 'shippments#showByOrderNumber'
      end
    end
  end

end
