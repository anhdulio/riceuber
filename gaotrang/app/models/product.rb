class Product < ApplicationRecord
  include Dynamic
  validates_presence_of :name, :description, :available_on, :categories,
                        :meta_description, :meta_keywords, :price,
                        on: :create, message: "can't be blank"
  validates_date :available_on
  validates_numericality_of :price,
                            greater_than_or_equal_to: 0,
                            on: :create, message: "can't be negative number"
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
end

