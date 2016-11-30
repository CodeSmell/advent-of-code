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
  elsif char == 'v' || char == 'V'
    newLocation = Location.new(currLocation.x, currLocation.y - 1)
  elsif char == '<'
    newLocation = Location.new(currLocation.x - 1, currLocation.y)
  elsif char == '>'
    newLocation = Location.new(currLocation.x + 1, currLocation.y)
  end
  return newLocation
end

def processTheInstruction(instruction, currLocation, visitedLocations)
  tempLocation = visit(instruction, currLocation)
  if !tempLocation.nil?
    currLocation = tempLocation
    visitedLocations[currLocation.asString()]=true
  end
  return currLocation
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
    currentLocation = processTheInstruction(directions[i], currentLocation, visitedLocations)
  end
end

def processTheDirectionsPart2(directions, visitedLocations)
  # both Santa and Robo Santa starting @ same location
  currentSantaLocation = Location.new(0,0)
  currentRoboLocation = Location.new(0,0)

  visitedLocations[currentSantaLocation.asString()]=true

  # for each directional character
  # get a new location
  # and mark it as visited
  for i in 0..directions.length - 1
    if i % 2 == 0
      # Santa
      currentSantaLocation = processTheInstruction(directions[i], currentSantaLocation, visitedLocations)
    else
      # Robo
      currentRoboLocation = processTheInstruction(directions[i], currentRoboLocation, visitedLocations)
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
#processTheDirections(directions, visitedLocations)
processTheDirectionsPart2(directions, visitedLocations)
puts "Visited #{visitedLocations.keys.size} homes"