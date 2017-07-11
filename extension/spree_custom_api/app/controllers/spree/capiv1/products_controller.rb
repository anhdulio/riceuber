class Spree::Capiv1::ProductsController < ApplicationController
  def index
    @products = Spree::Product.all
  end
end
