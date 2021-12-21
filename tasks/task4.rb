# frozen_string_literal: true

# Create ruby file, which is running with passed argument, for example:
# ruby script.rb pwd
# Where ‘pwd’ is a command, which Ruby will run
# Ruby should execute command, which is passed and print it’s output to console
# If no argument is passed - print message ‘Please pass argument to the script’ - condition should be implemented as ternary operator

puts ARGV.size.zero? ? 'Please pass argument to the script' : system(ARGV[0].to_s)
puts ARGV.size.zero? ? 'Please pass argument to the script' : `#{ARGV[0]}`
puts ARGV.size.zero? ? 'Please pass argument to the script' : %x(#{ARGV[0]})
