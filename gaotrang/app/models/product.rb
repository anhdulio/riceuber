class Product < ApplicationRecord
  include Dynamic
  extend FriendlyId

  content_attr :img_url_sml
  content_attr :img_url_med
  content_attr :img_url_lrg

  has_many :cart_lines
  has_many :carts, through: :cart_lines

  validates_presence_of :name, :description, :available_on, :categories,
                        :meta_description, :meta_keywords, :price,
                        on: :create, message: "can't be blank"
  validates_date :available_on
  validates_numericality_of :price,
                            greater_than_or_equal_to: 0,
                            on: :create, message: "can't be negative number"
  friendly_id :slug_candidates, use: :slugged

  def self.search(keyword_args)
    unless keyword_args.empty?
      @where_clause = ''
      @values = []
      keyword_args.each_with_index do |hash, index|
        value = hash.last
        if index == 0
          @where_clause = "#{hash.first} ILIKE '%#{value}%'"
        else
          @where_clause += "OR #{hash.first} ILIKE '%#{value}%'"
        end
      end
      products = Product.where(@where_clause)
    end
  end

  def slug_candidates
    [
      :name,
      %i[name categories]
    ]
  end

end

