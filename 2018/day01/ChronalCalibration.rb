#
# Star 2
#
def whatIsTheRepeatedFrequency(values)
  # starting frequency
  currentFrequency = 0
  
  # tracking found frequencies
  # we count the starting frequency
  foundFrequencies = { currentFrequency => currentFrequency }
  
  index = 0
  loop do 
    currentFrequency += values[index].chomp.to_i
    break if !foundFrequencies[currentFrequency].nil?
    
    # add the found frequency
    foundFrequencies[currentFrequency] = currentFrequency
    
    # handle the index
    index = (index+1 > values.length-1) ? 0 : index+1
  end 
  
  return currentFrequency
end

#
# Star 1 
#
def whatIsTheFrequency(values)
  if values.length == 1
    return values[0].chomp.to_i
  else
    return values[0].chomp.to_i + whatIsTheFrequency(values.drop(1))
  end
end



driftFileName = "2018/day01/star1.txt"
# read every line in the file into an array
lines = IO.readlines(driftFileName)

# expecting only one line in file
# process comma delimited line 
#values = lines[0].split(/\s*,\s*/)
#puts "your frequency is : #{whatIsTheFrequency(values)}"

# actual input was delimited by lines
# not a comma on one line
puts "your frequency is : #{whatIsTheFrequency(lines)}"
puts "your repeated frequency is : #{whatIsTheRepeatedFrequency(lines)}"
