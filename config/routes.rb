Rails.application.routes.draw do
  root "quotes#index"
  resources :quotes, only: %i[index create]
  resource :quote_history, only: :destroy

  get "up" => "rails/health#show", as: :rails_health_check
end
