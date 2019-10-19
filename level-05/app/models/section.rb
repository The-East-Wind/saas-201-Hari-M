class Section < ApplicationRecord
    has_many :students, dependent: :destroy
    belongs_to :department
end
