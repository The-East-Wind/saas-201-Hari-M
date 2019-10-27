class AddRollNoToSection < ActiveRecord::Migration[5.2]
  def change
	add_column :students, :roll_no, :integer
  end
end
