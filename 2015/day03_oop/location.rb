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
  
  #
  # 2016 day 1 
  # calculate taxi cab distance
  # between two points
  def taxiCabDistance(anotherLocation)
    distance = 0
    
    if !anotherLocation.nil?
      distance = (x - anotherLocation.x).abs + (y - anotherLocation.y).abs
    end
    
    return distance
  end
end