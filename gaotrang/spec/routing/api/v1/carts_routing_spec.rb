require "rails_helper"

RSpec.describe 'Cart Routing Spec', type: :routing do
  describe "routing" do
  let(:url)     {'http://api.domain.com/v1'}
  let(:carts) {'api/v1/carts'}

    it "routes to #show" do
      expect(:get => "#{url}/carts/1").to route_to("#{carts}#show", :id => "1", subdomain: 'api')
    end

    it "routes to #create" do
      expect(:post => "#{url}/carts").to route_to("#{carts}#create", subdomain: 'api')
    end

    it "routes to #update via PUT" do
      expect(:put => "#{url}/carts/1").to route_to("#{carts}#update", :id => "1", subdomain: 'api')
    end

    it "routes to #update via PATCH" do
      expect(:patch => "#{url}/carts/1").to route_to("#{carts}#update", :id => "1", subdomain: 'api')
    end

    it "routes to #destroy" do
      expect(:delete => "#{url}/carts/1").to route_to("#{carts}#destroy", :id => "1", subdomain: 'api')
    end

  end
end
