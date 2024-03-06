Rails.application.routes.draw do
  root to: "emploies#index"

  resources :emploies, only: [:index] do
    collection do
      get 'import', to: 'emploies#import'
    end
  end
end
