class Bootcamp
    def initialize(name, slogan, student_capacity)
        @name = name
        @slogan = slogan
        @student_capacity = student_capacity
        @teachers = []
        @students = []
        @grades = Hash.new {|h,k| h[k] = []}
    end

    def name
        @name
    end

    def slogan
        @slogan
    end

    def teachers
        @teachers
    end

    def students
        @students
    end

    def hire(more_teacher)
        @teachers << more_teacher
    end
    
    def enroll(student)
        if students.length < student_capacity 
            students << student
            return true
        else
            return false
        end
    end

    def enrolled?(student)
        @students.include?(student)
    end


    def student_to_teacher_ratio
        @students.length / @teachers.lenght
    end

    def add_grade(student, grade)
        if self.enrolled?(student)
            @grades[student] << grade
            return true
        end
        false
    end

    def num_grades(student)
        @grades[student].lenght
    end

    def average_grade(student)
        if self.enrolled?(student) && self.num_grades(student) > 0
            grades = @grades[student]
            sum = 0 
            grades.each {|i| sum += i}
            return sum / grades.length
        end

        nil
    end

end
