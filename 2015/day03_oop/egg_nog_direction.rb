require_relative 'santa_handler'
require_relative 'robo_handler'

print('Enter the directions:')
directions = gets().chomp

#
# process the directions
#
santa = SantaHandler.new
robo = RoboHandler.new

puts("Santa Handler")
puts "Visited #{santa.visitedLocations} homes"
santa.processTheDirections(directions)
puts "Visited #{santa.visitedLocations} homes"

puts("RoboSanta Handler")
puts "Visited #{robo.visitedLocations} homes"
robo.processTheDirections(directions)
puts "Visited #{robo.visitedLocations} homes"