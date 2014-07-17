#!/usr/bin/env ruby

require_relative 'app'

# This simply creates, and runs our simple application.
#
print "Enter a string to parse: "
app = AutoTrader::App.new(input = gets.chomp)
result = app.run

# Show the results
#
puts "Input-: \"#{app.input}\""
puts "Output: \"#{result}\""
# puts "Word Cache: \"#{app.word_cache}\""

# Exit
#
exit 0
