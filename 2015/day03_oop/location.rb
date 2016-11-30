# Location on an X,Y graph
class Location
  def initialize(x,y)
    @x = x
    @y = y
  end

  def asString()
    return "#{x},#{y}"
  end

  attr_reader :x
  attr_reader :y
end