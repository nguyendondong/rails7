Rails.application.routes.draw do
  root "messages#index"
  resources :messages, except: [:show] do
    member do
      post :edit
    end
  end
end
