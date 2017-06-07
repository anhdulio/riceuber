class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :available_on, :slug, :categories,
             :meta_description, :meta_keywords, :price
end
