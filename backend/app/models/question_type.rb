class QuestionType < ApplicationRecord
  has_many :questions
  validates :content, presence: true
  validates_uniqueness_of :content
end