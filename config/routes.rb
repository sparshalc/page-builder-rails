# config/routes.rb
Rails.application.routes.draw do
  resources :pages do
    member do
      get :preview
    end
    resources :page_components do
      member do
        patch :move
        get :properties
      end
    end
  end

  resources :components
  resources :image_uploads, only: [ :create ]

  root "pages#index"
end
