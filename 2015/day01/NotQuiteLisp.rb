#
# determine which way to go 
# based on the character
#
def whichWayToGo(char, floor)
  if char == '(' 
    floor+=1
  elsif char == ')'
    floor-=1
  end
  return floor
end

#
# capture the input
# expects a series of ( and ) characters
# terminating with the enter key
#
def getTheInput()
  print('Enter the directions:')
  directions = gets().chomp
  return directions
end

#
# process the directions
#
def processTheDirections(directions)
  basementCharacter = 0
  currentFloor = 0
  for i in 0..directions.length
    currentFloor = whichWayToGo(directions[i], currentFloor)
    # part 2
    if basementCharacter == 0 && currentFloor < 0
      basementCharacter = i + 1
    end 
  end
  
  puts "you are on floor:#{currentFloor}"
  puts "you entered the basement on char:#{basementCharacter}"
end  

keepGoing = true
while (keepGoing)
  processTheDirections(getTheInput())
  
  print("play again (y/n):")
  if gets.chomp != "y"
    keepGoing = false
  end
end

