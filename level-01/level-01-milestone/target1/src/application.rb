require_relative './department' # Include other files in the same directory

# Your application
class Application
   attr_accessor :departments

  def initialize
    self.departments = []
    ['EEE', 'MECH', 'CSE', 'CIVIL'].each { |dept| departments<<Department.new(dept)}
  end

  def enroll(student_name, student_department)
    # This is a sample implementation. you can write your own code
    department = departments.detect { |x| x.name==student_department}
    if !department.nil?
      if department.check_dept_availability
        ret_val = []
        ret_val = department.enroll student_name
        return "You have been enrolled to #{student_department}" \
        "\nYou have been allotted section #{ret_val[0]}" \
        "\nYour roll number is #{ret_val[1]}"
      else
        return "Error: Seats are not available in #{student_department}"
      end
    end
  end

  def change_dept(student_name, student_department)
    ## write some logic to frame the string below
    new_department = departments.detect {|x| x.name==student_department}
    if new_department.check_dept_availability
      msg = find_student_dept student_name
      if !msg.empty?
        if msg[0..2].eql? "MEC"
          dept = "MECH"
        else
          dept = msg[0..2]
        end
        department = departments.detect { |x| x.name==dept}
        department.remove student_name,msg[3]
      end
      return enroll student_name,student_department
    else
      return "Error: Seats are not available in #{student_department}"
    end
    #"You have been enrolled to #{student_department}" \
    #"\nYou have been allotted section B" \
    #"\nYour roll number is MECB01"
  end

  def change_section(student_name, section)
    ## write some logic to frame the string below
    student_department = find_student_dept student_name
    if !student_department.empty?
      if student_department[0..2].eql? "MEC"
        dept = "MECH"
      else
        dept = student_department[0..2]
      end
      department = departments.detect {|x| x.name==dept}
      if department.check_sec_availability section
        department.remove student_name,student_department[3]
        roll_no = department.add_to_sec student_name,section
        return "You have been allotted section #{section}" \
        "\nYour roll number is #{roll_no}"
      end
    end
    return "Error: Seats are not available in #{section} section"
  end

  def department_view(student_dept)
    ## write some logic to frame the string below
    department = departments.detect { |x| x.name==student_dept}
    msg = department.view_dept_details 
    "List of students:" \
    "#{msg}"
    #"\nTom - MECB01"
  end

  def section_view(student_dept, section)
    ## write some logic to frame the string below
    department = departments.detect { |x| x.name==student_dept}
    msg = department.view_sec_details section
    "List of students:" \
    "#{msg}"
    #"\nTom - MECB01"
  end

  def student_details(student_name)
    ## write some logic to frame the string below
    stud_dept = find_student_dept student_name
    if !stud_dept.empty?
      if stud_dept[0..2].eql? "MEC"
        dept = "MECH"
      else
        dept = stud_dept[0..2]
      end
    end
    "#{student_name} - #{dept} - Section #{stud_dept[3]} - #{stud_dept}"
  end

  def find_student_dept(student_name)
    x = 0
    while x<4
      department = departments[x]
      msg = department.view_dept_details
      if !msg.empty?
        msg = msg.split("\n")
        msg.shift()
        y=0
        while y<msg.length
          temp = msg[y].split(" - ")
          if temp[0].eql? student_name
            return temp[1]
          end 
          y+=1
        end
      end
      x+=1
    end
    return ""
  end
end
