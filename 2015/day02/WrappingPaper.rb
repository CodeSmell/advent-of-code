##
## Wrapping Paper
##
def surfaceArea(l, w, h)
  return 2*l*w + 2*w*h + 2*h*l
end

def smallestSide(l, w, h)
  return [(l*w), (w*h), (l*h)].min
end

def paperNeededForPresent(l, w, h)
  return surfaceArea(l, w, h) + smallestSide(l, w, h)
end

##
## Ribbon and Bow
##
def perimeter(s1, s2)
  return s1 + s1 + s2 + s2
end

def volume(l, w, h)
  return l*w*h
end

def smallestPerimeter(l, w, h)
  return [perimeter(l,w), perimeter(w,h), perimeter(l,h)].min
end

def ribbonNeededForPresent(l,w,h)
  return smallestPerimeter(l,w,h) + volume(l,w,h)
end

#
# capture the input
# expecting each line to be one present
# in the format 2x3x4
#
print("Enter presents:")
totalPaperNeeded = 0;
totalRibbonNeeded = 0;
$stdin.each do |present|
  # have a way to indicate
  # we are done entering presents
  if present.chomp == 'DONE'
    break
  end
  # take the string (ie present) and split at the x
  # getting an array consisting of each measurement
  # then convert each measurement to an integer
  measurements = present.split("x").map {|measurement| measurement.to_i}

  # let's make sure we have 3 measurements for the present
  if measurements.size == 3
    totalPaperNeeded += paperNeededForPresent(measurements[0], measurements[1], measurements[2])
    totalRibbonNeeded += ribbonNeededForPresent(measurements[0], measurements[1], measurements[2])
  end
end
puts("END: total paper needed: #{totalPaperNeeded}")
puts("END: total ribbon needed: #{totalRibbonNeeded}")

