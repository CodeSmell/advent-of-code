# Location on an X,Y graph
class Location

  attr_reader :x
  attr_reader :y
  
  def initialize(x,y)
    @x = x
    @y = y
  end

  # calculate taxi cab distance
  # between two points
  def taxiCabDistance(anotherLocation)
    distance = 0

    if !anotherLocation.nil?
      distance = (x - anotherLocation.x).abs + (y - anotherLocation.y).abs
    end

    return distance
  end

  def asString()
    return "#{x},#{y}"
  end

  # convert x,y to Location
  def self.convertStringToLocation(pointString)
    values = pointString.split(/\s*,\s*/)
    return Location.new(values[0].to_i,values[1].to_i)
  end

end