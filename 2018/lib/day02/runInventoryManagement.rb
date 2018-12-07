require_relative 'InventoryManagement'

driftFileName = "star2.testData.txt"
# read every line in the file into an array
lines = IO.readlines(driftFileName)

im = InventoryManagement.new
checksum = im.checkSum(lines)
puts "your checksum is : #{checksum}"

boxIdOne, boxIdTwo = im.findMostlyMatchingBoxIds(lines)
puts "your two box ids are (#{boxIdOne}) and (#{boxIdTwo})"
puts "your new box id  is (#{im.removeDifferentCharacter(boxIdOne, boxIdTwo)})"