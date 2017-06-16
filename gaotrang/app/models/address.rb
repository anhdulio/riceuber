class Address < ApplicationRecord
  include Dynamic
  content_attr :instruction
  content_attr :type

  belongs_to :order
end
