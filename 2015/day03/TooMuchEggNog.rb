# Santa begins by delivering a present to the house at his starting location,
# An elf tells him where to move next.
# Moves are always exactly one house to the north (^), south (v), east (>), or west (<).
# After each move, he delivers another present to the house at his new location.

# simple class to
# keep track of Locations
# as we visit them
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

def visit(char, currLocation)
  newLocation = nil
  if char == '^'
    newLocation = Location.new(currLocation.x, currLocation.y + 1)
  elsif char == 'v'
    newLocation = Location.new(currLocation.x, currLocation.y - 1)
  elsif char == '<'
    newLocation = Location.new(currLocation.x - 1, currLocation.y)
  elsif char == '>'
    newLocation = Location.new(currLocation.x + 1, currLocation.y)
  end
  return newLocation
end

#
# process the directions
#
def processTheDirections(directions, visitedLocations)
  currentLocation = Location.new(0,0)
  visitedLocations[currentLocation.asString()]=true

  # for each directional character
  # get a new location
  # and mark it as visited
  for i in 0..directions.length - 1
    currentLocation = visit(directions[i], currentLocation)
    if !currentLocation.nil?
      visitedLocations[currentLocation.asString()]=true
    end
  end
end

#
# capture the input
# expects a series of ^,<,>,v characters
# terminating with the enter key
#
print('Enter the directions:')
directions = gets().chomp
#
# process the directions
#
visitedLocations = Hash.new
processTheDirections(directions, visitedLocations)
puts "Visited #{visitedLocations.keys.size} homes"