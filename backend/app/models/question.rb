class Question < ApplicationRecord
    belongs_to :question_type
    has_many :question_choices
    validates :content, presence: true
    validates_presence_of :question_type
    validates_presence_of :question_choices, if: :validate_choice
    
    def validate_choice
        if self.content
            if self.question_type
                question_type = self.question_type.content
                return question_type == "multiple" || question_type == "selection"
            end 
        end
    end

end
