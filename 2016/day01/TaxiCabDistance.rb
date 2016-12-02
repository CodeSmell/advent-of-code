require_relative '../../2015/day03_oop/location'

# turn towards a new direction 
def changeFacingDirection(currFacing, turnCommand)
  newFacingDirection = ""
  case currFacing + turnCommand
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
end

# return the location where you are after moving the
# specified number of blocks in the direction you are facing
def advanceToNextLocation(currLocation, currFacing, numBlocks)
  nextLocation = currLocation

  if currFacing == "E"
    nextLocation = Location.new(currLocation.x + numBlocks, currLocation.y)
  elsif currFacing == "W"
    nextLocation = Location.new(currLocation.x - numBlocks, currLocation.y)
  elsif currFacing == "N"
    nextLocation = Location.new(currLocation.x, currLocation.y + numBlocks)
  elsif currFacing == "S"
    nextLocation = Location.new(currLocation.x, currLocation.y - numBlocks)
  end

  return nextLocation
end

# return the location where you are after moving the
# specified number of blocks in the direction you are facing
# but keep track of all the locations you pass along the way
# and stop if you visited a location more than once
def advanceToNextLocationVisitAll(currLocation, currFacing, numBlocks, visitedLocations)
  nextLocation = currLocation
  for i in 1..numBlocks
    # advance one block in the direction you are facing
    if currFacing == "E"
      nextLocation = Location.new(nextLocation.x + 1, nextLocation.y)
    elsif currFacing == "W"
      nextLocation = Location.new(nextLocation.x - 1, nextLocation.y)
    elsif currFacing == "N"
      nextLocation = Location.new(nextLocation.x, nextLocation.y + 1)
    elsif currFacing == "S"
      nextLocation = Location.new(nextLocation.x, nextLocation.y - 1)
    end
    
    puts("visited #{nextLocation.asString} along the way")
    
    if visitedLocations[nextLocation.asString]
      # already visited this location
      visitedLocations[nextLocation.asString]=visitedLocations[nextLocation.asString] + 1
      puts("**** visited twice #{nextLocation.asString}")
      break
    else
      # we have not visited the location yet
      # so marked it as visited
      visitedLocations[nextLocation.asString]=1
    end
  end
  return nextLocation
end

def processDirections(startFacing, startingLocation, directions, endOnSecondVisit)
  # starting position
  currFacing = startFacing
  currLocation = startingLocation

  # visitedLocations
  visitedLocations = Hash.new
  visitedLocations[startingLocation.asString]=true

  # process each direction item
  directions.each { |dir|
    directionToTurn = dir[0]
    numberOfBlocks = dir[1..dir.length].to_i
    currFacing = changeFacingDirection(currFacing, directionToTurn)
    if !endOnSecondVisit 
      currLocation = advanceToNextLocation(currLocation, currFacing, numberOfBlocks)
    else
      currLocation = advanceToNextLocationVisitAll(currLocation, currFacing, numberOfBlocks, visitedLocations)
      if visitedLocations[currLocation.asString] > 1
        break
      end
    end
    puts("turned #{directionToTurn} toward #{currFacing} and went #{numberOfBlocks} so now at #{currLocation.asString}")
  }

  return currLocation
end

print('Enter the directions:')
directions = gets().chomp.split(/\s*,\s*/)

# starting position
currFacing = "N"
startingLocation = Location.new(0,0)
endingLocation = processDirections(currFacing, startingLocation, directions, false)
distance = startingLocation.taxiCabDistance(endingLocation)
puts("taxicab distance to HQ is #{distance} blocks")