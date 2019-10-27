class Department < ApplicationRecord
	#associations
	has_many :students, :through => :sections
	has_many :sections,:dependent => :destroy
	#validations
	validates :name, presence: true, uniqueness: true
	#callbacks
	before_create :change_to_capital

	private
	def change_to_capital
		self.name = self.name.upcase
	end
end
