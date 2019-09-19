require "employee"

class Startup
    attr_reader :name, :funding, :salary, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
    # salaries is hash
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        @salaries.has_key?(title)
    end

    def >(other_startup)
        self.funding > other_startup.funding 
    end

    def hire(employee_name, title)
        if self.valid_title?(title)
            @employees <<  Employee.new(employee_name, title)
        else
    # raise thr error
            raise " title is invalid"
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        money_owned = @salaries[employee.title]

        if @funding >= money_owned
            employee.pay(money_owned)
            @funding -= money_owned
        else
            raise "not enough funding"
        end
    end

    def payday
        @employees.each do |employee|
            self.pay_employee(employee)
        end
    end


    def average_salary
        sum = 0 

        @employees.each do |employee|
            sum += @salaries[employee.title]
        end

        sum / (employees.length * 1.0)
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup)
        #add funding
        @funding += startup.funding

        # merger salaries
        startup.salaries.each do |title, amount|
            if !@salaries.has_key?(title)
                @salaries[title] = amount
            end
        end

        # hire employees (employees is an arr += used to cancat 2 arr)
        @employees += startup.employees

        #close the other startup
        startup.close
    end

end
