class Student < ApplicationRecord
	#associations
	belongs_to :section
	belongs_to :department
	
	#validations
	validates :email, uniqueness: true
	validates :name, :presence => true
	validates :section_id, :presence=>true
	validates :department_id, :presence=>true

	validate :validate_section_mapping
	
	#callbacks
  	before_create :generate_roll_no

 	private

 	def validate_section_mapping
    		section = Section.find_by_id(section_id)
		if section
    			if section.department_id!=department_id
      				errors.add(:section, "Selected section doesn't belongs to selected department")
    			end
		end
  	end
	
	def generate_roll_no
    		max_count = Student.count
    		department_name = department.name.downcase.gsub(/\s/, '-')
    		section_name = section.name.downcase.gsub(/\s/, '-')
    		self.roll_no = "#{department_name}-#{section_name}-#{max_count+1}"
  	end
end

