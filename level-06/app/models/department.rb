class Department < ApplicationRecord
	has_many :students, :through => :sections
	has_many :sections,:dependent => :destroy
end
