class Triangle
  attr_reader :l
  attr_reader :w
  attr_reader :h  
  def initialize(l, w, h)
    @l = l
    @w = w
    @h = h
  end
  
  def isTriangle?()
    return (@l + @w > @h) && (@l + @h > @w) && (@h + @w > @l)
  end
end

def checkTriangle(l, w, h)
  tri = Triangle.new(l, w, h)
  if tri.isTriangle?
    return 1
  else
    return 0
  end
end

def part1(data)
  validTriangles = 0
  data.split("\n").each { |triangle|
    sides = triangle.chomp.split(' ')
    validTriangles = validTriangles + checkTriangle(sides[0].to_i, sides[1].to_i, sides[2].to_i)
  }
  return validTriangles
end

def part2(data)
  validTriangles = 0
  
  dataArray = data.split("\n")
  # loop over every 3rd data item
  (0..dataArray.length - 1).step(3).each do |i|
    if dataArray[i] == "DONE" 
      break
    end
    # get the sides out of the data 
    # for the current item
    # and the next two as well 
    # since data spans three lines 
    sides1 = dataArray[i].chomp.split(' ')
    sides2 = dataArray[i + 1].chomp.split(' ')
    sides3 = dataArray[i + 2].chomp.split(' ')

    # process each of the 3 triangles    
    (0..2).each do |j| 
      validTriangles = validTriangles + checkTriangle(sides1[j].to_i, sides2[j].to_i, sides3[j].to_i)
    end
  end
  return validTriangles
end

print('Enter the triangles:')
$/ = 'DONE'
user_input = STDIN.gets
valid = part1(user_input)
puts("there were #{valid} valid triangles (part 1)")
valid = part2(user_input)
puts("there were #{valid} valid triangles (part 2)")