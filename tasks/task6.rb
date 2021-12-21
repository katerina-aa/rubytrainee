# frozen_string_literal: true

# Create class Business
# Business has name and workers.
# Business can print it’s name and current amount of workers.
# Business can print information on all of workers attributes - each ones name, surname, specialization and salary
class Business
  attr_accessor :name, :workers

  def initialize(name)
    @name = name
    @workers = []
  end

  def add_worker(worker)
    @workers << worker
  end

  def business_info
    puts "Business name is #{@name} and current amount of workers is #{@workers.size}."
  end

  def workers_info
    @workers.each_with_index do |elem, i|
      puts "Info abour worker number #{i + 1}:"
      elem.info
    end
  end
end

# Consider using inheritance
# Consider in what types of variables should information be kept
class Worker
  attr_reader :salary_accountant
  attr_accessor :name, :surname, :experience, :specialization, :salary_per_year

  def initialize(name, surname, experience, specialization)
    @name = name
    @surname = surname
    @experience = experience
    @specialization = specialization
    @salary_per_year = 0
  end

  def show_salary_per_year
    puts "Salary per week for #{self.class} is #{@salary_per_year}."
  end

  def show_salary_total
    puts "Total salary is #{@salary_per_year * @experience}."
  end

  def info
    puts "Name and surname: #{@name} #{@surname}, specialization: #{@specialization}, salary: #{@salary_per_year}."
  end
end

# Create class WorkerAccountant
# Has fixed salary per year attribute - 2000
# WorkerAccountant has attributes - name, surname, experience, specialisation
# WorkerAccountant can print or return his salary
# WorkerAccountant’s salary is calculated based on formula — fixed salary per year * experience
class WorkerAccountant < Worker
  def initialize(name, surname, experience, specialization)
    super
    @salary_per_year = 2000
  end
end

# Create class WorkerLawyer
# Has fixed salary per year attribute - 3000
# WorkerLayer has attributes - name, surname, experience, specialisation
# WorkerLayer can print or return his salary
# WorkerLayer’s salary is calculated based on formula — fixed salary per year * experience
class WorkerLawyer < Worker
  def initialize(name, surname, experience, specialization)
    super
    @salary_per_year = 3000
  end
end

worker1 = WorkerAccountant.new('Kateryna', 'Bielenova', 2, 'credit')
worker1.show_salary_per_year
worker1.show_salary_total

worker2 = WorkerLawyer.new('Andrii', 'Mishchuk', 10, 'criminal')
worker2.show_salary_per_year
worker2.show_salary_total

business1 = Business.new('Accountant')
business1.add_worker(worker1)
business1.add_worker(worker2)
business1.business_info
business1.workers_info
