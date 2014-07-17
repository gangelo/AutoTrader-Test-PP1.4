#!/usr/bin/env ruby

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

    attr_reader :input

    private

    attr_accessor :word_cache

    public

    def initialize(input)
      @input = input || ''
      @word_cache = {}
    end

    def run
      return 'No string entered.' if @input.empty?

      # Split the string in to tokens, delimited by start/end of line and space; this
      # ensures that we maintain the position of non-alphabetic word separators, as
      # well as the spaces, by implication, which will be added between tokens when
      # we ultimately join the tokens back in to the original string.
      #
      # /(\s* )/ # => treats spaces as separate tokens/group
      # /(\s*[a-zA-z]+)/ # => maintains leading spaces in tokens.
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
      # or, be all non-alphabetic characters e.g. ####, @@@, two#words, etc.
      #
      unless token.index(/[^a-zA-Z\s]+/).nil?
        # If the token ONLY contains NON-alphabetic characters, just return it;
        # otherwise we just get caught in a loop trying to tokenize a non-alphabetic
        # token.
        #
        return token if token.match(/([a-zA-Z]+)/).nil?

        # If we get here, we have a case of something like this: two#words.
        #
        return tokenize(/([a-zA-Z]+|[^a-zA-Z]+)/, token).map! {|t| t = transform! t}.join
      end

      # Save the token to the cache, so we can just return the previously transformed
      # token without processing it multiple times - we may run in to the same word
      # again.
      #
      if @word_cache.has_key? token.to_sym
        return @word_cache[token.to_sym]
      end

      output = token[0] + token.byteslice(1...-1).downcase.chars.sort.join.squeeze.length.to_s + token[-1]
      @word_cache[token.to_sym] = output
      output
    end
  end # App

end #AutoTrader

# This simply creates, and runs our simple application.
#
print "Enter a string to parse: "
app = AutoTrader::App.new(input = gets.chomp)
result = app.run

# Show the results
#
puts "Input-: \"#{app.input}\""
puts "Output: \"#{result}\""

# Exit
#
exit 0
