# Small extension to core String class to make out code mote tidy. Woudln't
# normally want to make a global change like this, but it's okay for this
# little test app.
#
class String

  # Compresses the value of this object, and returns the resulting compression
  # value (e.g. "AbbcdE".compress #=> 3).
  #
  def compress
    self.byteslice(1...-1).downcase.chars.sort.join.squeeze.length
  end

=begin
  protected

  # This method simply makes sure we're dealing with an object capable of
  # being compressed properly (e.g. implements the proper methods and
  # properties).
  #
  def duck?
    instance_of? :string
  end

  # We basically need to be dealing with a string object, so if we are, just
  # return self, otherwise, convert us to a string object.
  #
  def to_duck
    duck? ? self : self.to_s
  end
=end
end
