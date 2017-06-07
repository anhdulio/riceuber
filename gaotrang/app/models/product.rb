class Product < ApplicationRecord
  include Dynamic
  validates_presence_of :name, :description, :available_on, :categories,
                        :meta_description, :meta_keywords, :price,
                        on: :create, message: "can't be blank"
  validates_date :available_on
  validates_numericality_of :price,
                            greater_than_or_equal_to: 0,
                            on: :create, message: "can't be negative number"

end
