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
end
