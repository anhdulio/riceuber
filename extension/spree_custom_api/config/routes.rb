Spree::Core::Engine.routes.draw do

  namespace :capiv1 do
    resources :products
  end

  # Add your extension routes here
end
