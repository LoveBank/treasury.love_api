Rails.application.routes.draw do

  resources :profiles do
    resources :entries
  end

end
