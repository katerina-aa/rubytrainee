=begin

Create class Business
Business has name and workers.
Business can print it’s name and current amount of workers.
Business can print information on all of workers attributes - each ones name, surname, specialization and salary

Create class WorkerAccountant
Has fixed salary per year attribute - 2000
WorkerAccountant has attributes - name, surname, experience, specialisation
WorkerAccountant can print or return his salary
WorkerAccountant’s salary is calculated based on formula — fixed salary per year * experience

Create class WorkerLawyer
Has fixed salary per year attribute - 3000
WorkerLayer has attributes - name, surname, experience, specialisation
WorkerLayer can print or return his salary
WorkerLayer’s salary is calculated based on formula — fixed salary per year * experience

Consider using inheritance
Consider in what types of variables should information be kept

=end

class Business
    attr_accessor :name, :workers

    def initialize(name)
        @name = name
        @workers = []
    end

    def add_worker(name_of_business, worker)
        @workers << worker if @name == name_of_business 
    end

    def business_info()
        puts "Business name is #{@name} and current amount of workers is #{@workers.size}."
    end

    def workers_info()
        i = 1
        @workers.each do |elem|
            puts "Info abour worker number #{i}:"
            puts "Name and surname: #{elem.name} #{elem.surname}, specialization: #{elem.specialization}, salary: #{elem.salary_per_year}."
            i += 1
        end
    end
end

class WorkerAccountant 
    attr_reader :salary_accountant
    attr_accessor :name, :surname, :experience, :specialization, :salary_per_year 

    def initialize(name, surname, experience, specialization)
        @name = name
        @surname = surname
        @experience = experience
        @specialization = specialization
        @salary_per_year = 2000
    end
    
    def get_salary_per_year()
        puts "Salary per week for #{self.class} is #{@salary_per_year}."
    end

    def get_salary_total()
        puts "Total salary is #{@salary_per_year * @experience}."
    end
end

class WorkerLawyer < WorkerAccountant
    def initialize(name, surname, experience, specialization)
        super
        @salary_per_year = 3000
    end
end

worker1 = WorkerAccountant.new('Kateryna', 'Bielenova', 2, 'credit')
worker1.get_salary_per_year()
worker1.get_salary_total()

worker2 = WorkerLawyer.new('Andrii', 'Mishchuk', 10, 'criminal')
worker2.get_salary_per_year()
worker2.get_salary_total()

business1 = Business.new('Accountant')
business1.business_info()
business1.add_worker('Accountant', worker1)
business1.workers_info()
business1.add_worker('Accountant', worker2)
business1.business_info()
business1.workers_info()
