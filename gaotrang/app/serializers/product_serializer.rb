class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :available_on, :slug, :categories,
             :meta_description, :meta_keywords, :price,
             :img_url_sml,  :img_url_med, :img_url_lrg
end
