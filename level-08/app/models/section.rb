class Section < ApplicationRecord
	 #associations
	 belongs_to :department
	 has_many :students , :dependent => :destroy
	 #callbacks
	 before_create :change_to_capital

	 private
	 def change_to_capital
	 	self.name = self.name.upcase
	 end
end
