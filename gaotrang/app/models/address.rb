class Address < ApplicationRecord
  include Dynamic
  belongs_to :order
end
