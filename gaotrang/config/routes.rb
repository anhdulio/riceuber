Rails.application.routes.draw do
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  constraints subdomain: 'api' do
    scope module: 'api' do
      namespace :v1 do
        resources :products
      end
    end
  end
end
