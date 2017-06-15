require "rails_helper"

RSpec.describe 'Product Routing Spec', type: :routing do
  describe "routing" do
  let(:url)     {'http://api.domain.com/v1'}
  let(:products) {'api/v1/products'}

    it "routes to #index" do
      expect(:get => "#{url}/products").to route_to("#{products}#index", subdomain: 'api')
    end


    it "routes to #show" do
      expect(:get => "#{url}/products/1").to route_to("#{products}#show", :id => "1", subdomain: 'api')
    end


    it "routes to #create" do
      expect(:post => "#{url}/products").to route_to("#{products}#create", subdomain: 'api')
    end

    it "routes to #update via PUT" do
      expect(:put => "#{url}/products/1").to route_to("#{products}#update", :id => "1", subdomain: 'api')
    end

    it "routes to #update via PATCH" do
      expect(:patch => "#{url}/products/1").to route_to("#{products}#update", :id => "1", subdomain: 'api')
    end

    it "routes to #destroy" do
      expect(:delete => "#{url}/products/1").to route_to("#{products}#destroy", :id => "1", subdomain: 'api')
    end

  end
end
