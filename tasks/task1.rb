=begin

Create class, which contains instance, class and global variable.
Create methods in class, which do manipulation(puts, calculates something based on it, etc.) with each type of variable: local, instance, class, global
Create method in class, which would use string interpolation(this can be simple puts of one of the variables).

=end

class Calculator

    @@class_first = 7
    @@class_second = 8

    def initialize()
        @instance_first = 2
        @instance_second = 3
    end

    def instance_manipulation()
        puts "Results of your manipulation with instance variables are:
        #{@instance_first} + #{@instance_second} = #{@instance_first + @instance_second}
        #{@instance_first} - #{@instance_second} = #{@instance_first - @instance_second}
        #{@instance_first} * #{@instance_second} = #{@instance_first * @instance_second}"
    end
 
    def local_manipulation()
        local_first = 4
        local_second = 4
        puts "Results of your manipulation with local variables are:
        #{local_first} + #{local_second} = #{local_first + local_second}
        #{local_first} - #{local_second} = #{local_first - local_second}
        #{local_first} * #{local_second} = #{local_first * local_second}"
    end

    def global_manipulation()
        puts "Results of your manipulation with global variables are:
        #{$global_first} + #{$global_second} = #{$global_first + $global_second}
        #{$global_first} - #{$global_second} = #{$global_first - $global_second}
        #{$global_first} * #{$global_second} = #{$global_first * $global_second}"
    end

    def class_manipulation()
        puts "Results of your manipulation with class variables are:
        #{@@class_first} + #{@@class_second} = #{@@class_first + @@class_second}
        #{@@class_first} - #{@@class_second} = #{@@class_first - @@class_second}
        #{@@class_first} * #{@@class_second} = #{@@class_first * @@class_second}"
    end

end

$global_first = 5
$global_second = 6

example1 = Calculator.new()
example1.instance_manipulation()
example1.local_manipulation()
example1.global_manipulation()
example1.class_manipulation()