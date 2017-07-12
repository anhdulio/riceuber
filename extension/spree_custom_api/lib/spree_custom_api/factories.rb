FactoryGirl.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'spree_custom_api/factories'
  factory :product_with_images, parent: :product do
    after(:create) do |product|
      image = create(:image)
      product.images << image
      product.save
    end
  end
end
