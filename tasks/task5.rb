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
        statistics()
    end

    private
    def statistics()
        all_lines = 0
        empty_lines = 0
        with_y_lines = 0
        
        @file.readlines.each do |line|
            all_lines += 1
            empty_lines += 1 if line.eql?("\n")
            with_y_lines += 1 if line.include?("y")
        end

        puts "Number of lines in file is #{all_lines}."
        puts "Number of empty lines in file is #{empty_lines}."
        puts "Number of lines containing letter ‘y’ is #{with_y_lines}."
    end

end

FileAnalyzer.new('test.txt')
