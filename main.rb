#!/usr/bin/env ruby

require_relative 'string'

=begin
PP 1.4: In the programming language of your choice, write a program that parses
a sentence and replaces each word with the following: first letter, number of
distinct characters between first and last character, and last letter.  For
example, Smooth would become S3h.  Words are separated by spaces or
non-alphabetic characters and these separators should be maintained in their
original form and location in the answer.

We are looking for accuracy, efficiency and solution completeness. Please
include this problem description in the comment at the top of your solution.
The problem is designed to take approximately 1-2 hours.
=end

module AutoTrader

  # The little test app.
  #
  class App
    VERSION = '0.0.1'

    # Read-only properties
    #
    attr_reader :input, :word_cache

    # Our constructor. Takes user input as the parameter.
    #
    def initialize(input)
      @input = input || ''
      @word_cache = {}
    end

    # This method runs the little app.
    #
    def run
      # Return an error message if no string (sentence) was entered.
      #
      return 'No string entered.' if @input.empty?

      # Split the string in to tokens, delimited by start/end of line and space; this
      # ensures that we maintain the position of non-alphabetic word separators, as
      # well as the spaces, which will all be joined to obtain our resulting string.
      #
      tokenize(/(\s* )/, @input).map! {|t| t = transform! t}.join
    end

    private

    # Splits a string, based on the rules of the passed regex.
    #
    def tokenize(regex, string)
      string.split(regex)
    end

    # Transforms tokens in the string, according to the test specs.
    #
    def transform!(token)
      # Make sure we're not dealing with a nil token.
      #
      token ||= ''

      # Just return the unaltered token if it's empty - we want to preserve
      # those spaces as they appeared in the original input string.
      #
      return token if token.strip.chomp.empty?

      # Trap and process any tokens that have embedded, non-alphabetic characters,
      # or, all non-alphabetic characters e.g. ####, @@@, two#words, etc.
      #
      unless token.index(/[^a-z\s]+/i).nil?
        # If the token ONLY contains NON-alphabetic characters, just return it;
        # otherwise we just get caught in a loop trying to tokenize a non-alphabetic
        # token.
        #
        return token if token.match(/([a-z]+)/i).nil?

        # If we get here, we have a case of something like this: two#words.
        #
        return tokenize(/([a-z]+|[^a-z]+)/i, token).map! {|t| t = transform! t}.join
      end

      # Save the token to the cache, so we can just return the previously transformed
      # token without processing it multiple times - we may run in to the same word
      # again.
      #
      if @word_cache.has_key? token.to_sym
        return @word_cache[token.to_sym]
      end

      # Lastly, simply interpolate the compressed numeric value between the
      # first and last characters of the word.
      #
      output = "#{token[0]}#{token.compress}#{token[-1]}"
      @word_cache[token.to_sym] = output
      output
    end
  end # App

end # AutoTrader

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
