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

      namespace :car do
        get '/:vin', to: 'cars#show'
      end

      namespace :order do
        # Orders
        get '/', to: 'orders#show'
        post '/create_shippment', to: 'orders#create_shippment'
        get '/options', to: 'orders#detail_options'
        patch '/', to: 'orders#modify_state'
      end

      namespace :shipper do
        # Shippers
        get '/', to: 'shippers#show'
        get '/:id', to: 'shippers#show_by_id'
        post '/', to: 'shippers#create'
        put '/', to: 'shippers#update'
        delete '/', to: 'shippers#delete'
      end

      namespace :consignee do
        # Consignee
        get '/', to: 'consignees#show'
        get '/:id', to: 'consignees#show_by_id'
        post '/', to: 'consignees#create'
        put '/', to: 'consignees#update'
        delete '/', to: 'consignees#delete'
      end

      namespace :shippment do
        # Shippments
        get '/', to: 'shippments#show'
        get '/:order_number', to: 'shippments#showByOrderNumber'

      end

      namespace :agent do
        # Agent
        get '/', to: 'agents#show'
        get '/:id', to: 'agents#show_by_id'
        post '/', to: 'agents#create'
        put '/', to: 'agents#update'
        delete '/', to: 'agents#delete'
      end

      namespace :issuing_company do
        # IssuingCompoany
        get '/', to: 'issuing_companies#show'
        get '/:id', to: 'issuing_companies#show_by_id'
        post '/', to: 'issuing_companies#create'
        put '/', to: 'issuing_companies#update'
        delete '/', to: 'issuing_companies#delete'
      end

      namespace :mode_of_transportation do
        # mode of transportation
        get '/', to: 'mode_of_transportations#show'
        get '/:id', to: 'mode_of_transportations#show_by_id'
        post '/', to: 'mode_of_transportations#create'
        put '/', to: 'mode_of_transportations#update'
        delete '/', to: 'mode_of_transportations#delete'
      end

      namespace :container do
        # container
        get '/', to: 'containers#show'
        get '/:id', to: 'containers#show_by_id'
        post '/', to: 'containers#create'
        put '/', to: 'containers#update'
        delete '/', to: 'containers#delete'
      end

      namespace :commodity do
        # commodity
        post '/', to: 'commodities#create'
        put '/', to: 'commodities#update'
        delete '/', to: 'commodities#delete'
      end

      namespace :charge do
        # commodity
        get '/', to: 'charges#show'
        post '/', to: 'charges#create'
        delete '/', to: 'charges#delete'
      end

      namespace :service do
        get '/', to: 'services#show'
      end

      namespace :order_state do
        get '/', to: 'order_states#show'
      end

    end
  end

end
