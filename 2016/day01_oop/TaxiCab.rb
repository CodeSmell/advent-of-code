require_relative '../../2015/day03_oop/location'

class TaxiCab
  attr_reader :startingLocation
  attr_reader :currLocation
  attr_reader :currFacing
  #
  # setup an instance variable
  # to keep track of places we visit
  #
  def initialize(directionFacing, startingLocation, visitHandler)
    @startingLocation = startingLocation
    @currLocation = startingLocation
    @currFacing = directionFacing
    @visitHandler = visitHandler
    @visitedLocations  = Hash.new
    @visitedLocations[startingLocation.asString]=1
  end

  def move(directionToTurn, numberOfBlocks)
    self.changeFacingDirection(directionToTurn)
    return self.advanceToNextLocationVisitAll(numberOfBlocks)
  end

  # turn towards a new direction
  def changeFacingDirection(turnCommand)
    newFacingDirection = ""
    case @currFacing + turnCommand
    when "NR"
      newFacingDirection = "E"
    when "NL"
      newFacingDirection = "W"
    when "SR"
      newFacingDirection = "W"
    when "SL"
      newFacingDirection = "E"
    when "ER"
      newFacingDirection = "S"
    when "EL"
      newFacingDirection = "N"
    when "WR"
      newFacingDirection = "N"
    when "WL"
      newFacingDirection = "S"
    end

    @currFacing = newFacingDirection
  end

  # return the location where you are after moving the
  # specified number of blocks in the direction you are facing
  # but keep track of all the locations you pass along the way
  def advanceToNextLocationVisitAll(numBlocks)
    keepMoving = true
    nextLocation = @currLocation

    for i in 1..numBlocks
      # advance one block in the direction you are facing
      if @currFacing == "E"
        nextLocation = Location.new(nextLocation.x + 1, nextLocation.y)
      elsif @currFacing == "W"
        nextLocation = Location.new(nextLocation.x - 1, nextLocation.y)
      elsif @currFacing == "N"
        nextLocation = Location.new(nextLocation.x, nextLocation.y + 1)
      elsif @currFacing == "S"
        nextLocation = Location.new(nextLocation.x, nextLocation.y - 1)
      end

      @currLocation = nextLocation
      puts("visited #{nextLocation.asString} along the way")

      # mark the location as visited
      markAsVisited(nextLocation)
      # and see if we should continue moving
      if !@visitHandler.keepMoving?(nextLocation, @visitedLocations)
        keepMoving = false
        break
      end
    end
    return keepMoving
  end

  def markAsVisited(aLocation)
    key = aLocation.asString
    @visitedLocations[key] ? @visitedLocations[key]=@visitedLocations[key] + 1 : @visitedLocations[key]=1
  end
end

class AlwaysMovingVisitHandler
  def keepMoving?(aLocation, visitedLocations)
    return true
  end
end

class StopOnSecondVisitHandler
  def keepMoving?(aLocation, visitedLocations)
    continueMoving = true
    if visitedLocations[aLocation.asString] > 1
      puts("already visited #{aLocation.asString}")
      continueMoving = false
    end
    return continueMoving
  end
end

print('Enter the directions:')
directions = gets().chomp.split(/\s*,\s*/)

# starting position of taxi
taxiPart1 = TaxiCab.new("N", Location.new(0,0), AlwaysMovingVisitHandler.new)
taxiPart2 = TaxiCab.new("N", Location.new(0,0), StopOnSecondVisitHandler.new)

taxi = taxiPart1
# process each direction item
directions.each { |dir|
  directionToTurn = dir[0]
  numberOfBlocks = dir[1..dir.length].to_i
  if !taxi.move(directionToTurn, numberOfBlocks)
    puts("stop!")
    break
  end
 
  puts("turned #{directionToTurn} toward #{taxi.currFacing} and went #{numberOfBlocks} so now at #{taxi.currLocation.asString}")
}

distance = taxi.startingLocation.taxiCabDistance(taxi.currLocation)
puts("taxicab distance to HQ is #{distance} blocks")