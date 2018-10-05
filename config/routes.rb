Rails.application.routes.draw do
  resources :orders, only: %i[index show create]
end
