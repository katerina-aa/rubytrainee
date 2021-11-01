=begin

Create class FileAnalyzer
Based on the provided path, class should print out the following statistics of the file:
- number of lines in file
- number of empty lines in file
- number of lines containing letter ‘y’
Class should not have any public accessible methods.
All statistics should be printed on class instance creation - FileAnalyzer.new(’some_path’)

=end

class FileAnalyzer

    def initialize(some_path)
        @file = File.open(some_path)
        @file_text = @file.readlines.map{|x| x.chomp }
        statistics()
    end

    private
    def statistics()
        puts "Number of lines in file is #{@file_text.size}."
        puts "Number of empty lines in file is #{empty_lines()}."
        puts "Number of lines containing letter ‘y’ is #{contains_y()}."
    end

    def empty_lines()
        counter = 0
        @file_text.each { |line| counter +=1 if line.empty? }
        return counter
    end

    def contains_y()
        counter = 0
        @file_text.each { |line| counter +=1 if line.include?("y") }
        return counter
    end
end

FileAnalyzer.new('test.txt')
