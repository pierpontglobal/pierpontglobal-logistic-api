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
      get '/test', to: 'base_api#test'
    end
  end

end
