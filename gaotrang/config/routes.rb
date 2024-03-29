Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  constraints subdomain: 'api' do
    scope module: 'api' do
      namespace :v1 do
        resources :products
        resources :carts, only: %i[show create update destroy] do
          resources :cartlines, only: %i[create update destroy]
        end
        post 'carts/:id/checkout' => 'carts#checkout', as: :cart_checkout
      end
    end
  end
end
