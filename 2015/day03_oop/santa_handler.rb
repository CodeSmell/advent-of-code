require_relative 'location'

class SantaHandler
  #
  # setup an instance variable
  # to keep track of places we visit
  #
  def initialize
    @visitedLocations  = Hash.new
  end

  #
  # given a location, move to a new location
  # based on a directional instruction
  #
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

  #
  # given a location, move to a new location
  # based on a directional instruction
  #
  def processTheInstruction(instruction, currLocation)
    tempLocation = visit(instruction, currLocation)
    if !tempLocation.nil?
      currLocation = tempLocation
      @visitedLocations[currLocation.asString()]=true
    end
    return currLocation
  end

  #
  # how many locations were visited
  #
  def visitedLocations
    return @visitedLocations.keys.size
  end

  #
  # process the directions
  #
  def processTheDirections(directions)
    currentLocation = Location.new(0,0)
    @visitedLocations[currentLocation.asString()]=true

    # for each directional character
    # get a new location
    # and mark it as visited
    for i in 0..directions.length - 1
      currentLocation = processTheInstruction(directions[i], currentLocation)
    end
  end

end