
class Section
    attr_accessor :strength
    attr_accessor :students
    attr_accessor :name
    def initialize(name)
        @name = name
        @strength = 10
        @students = []
    end
    def enroll(student_name,dept)
        @strength-=1
        @students<<student_name
        @students = @students.sort
        roll_no = @students.index(@students.detect {|x| x==student_name })
        roll_no+=1
        roll_no = dept[0..2]+@name+(sprintf "%02d",roll_no)
        return roll_no
    end
    def remove(student_name)
        @strength+=1
        index = @students.index(student_name)
        @students.delete_at(index)
        @students.sort
    end
end

class Department
    attr_accessor :sections
    attr_accessor :name
    def initialize(name)
        @name = name
        @sections = []
        ['A','B','C'].each do |sec| @sections<<Section.new(sec) end
    end
    def enroll(student_name)
        ret_val = []
        section = @sections.detect { |x| x.strength!=0 }
        if !section.nil?
            ret_val[0]= section.name
            ret_val[1] = section.enroll(student_name,@name)
        end
        return ret_val
    end
    def view_dept_details
        x = 0 
        msg = ""
        while x<3
            section = @sections[x]
            y=0
            while(y<(10-section.strength))
                temp="\n#{section.students[y]} - #{@name[0..2]+section.name+(sprintf "%02d",y+1)}"
                msg+=temp
                y+=1
            end
            x+=1
        end
        return msg
    end
    def view_sec_details(section_name)
        section = @sections.detect { |x| x.name==section_name }
        x=0
        msg = ""
        while(x<(10-section.strength))
            temp="\n#{section.students[x]} - #{@name[0..2]+section.name+(sprintf "%02d",x+1)}"
            msg+=temp
            x+=1
        end
        return msg
    end
    def check_dept_availability
        x = 0
        while x<3
            section = @sections[x]
            if section.strength>0
                return true
            end
            x+=1
        end
        return false
    end 

    def remove(student_name,student_section)
        section = @sections.detect{|x| x.name==student_section}
        if !section.nil?
            section.remove student_name
        end
    end

    def check_sec_availability(section_name)
        section = @sections.detect{|x| x.name==section_name}
        if section.strength>0
            return true
        else
            return false
        end
    end
    
    def add_to_sec(student_name,section_name)
        section = @sections.detect{|x| x.name==section_name}
        ret_val = 0
        if !section.nil?
            ret_val = section.enroll student_name,@name
        end
        return ret_val
    end
end
