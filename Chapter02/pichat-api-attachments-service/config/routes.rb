Rails.application.routes.draw do
  resources :messages do
    resources :attachments, except: :update
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  get '', to: 'root#index'
end
