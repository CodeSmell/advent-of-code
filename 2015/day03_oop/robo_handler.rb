class RoboHandler < SantaHandler
  #
  # override 
  #
  def processTheDirections(directions)
    # both Santa and Robo Santa starting @ same location
    currentSantaLocation = Location.new(0,0)
    currentRoboLocation = Location.new(0,0)
  
    @visitedLocations[currentSantaLocation.asString()]=true

    # for each directional character
    # get a new location
    # and mark it as visited
    for i in 0..directions.length - 1
      if i % 2 == 0
        currentSantaLocation = processTheInstruction(directions[i], currentSantaLocation)
      else
        currentRoboLocation = processTheInstruction(directions[i], currentRoboLocation)
      end
    end
  end
end