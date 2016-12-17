require_relative '../../2015/day03_oop/location'
require_relative 'MakeMaze'

class MazeLocation < Location
  attr_accessor :distance
  attr_reader :parent
  def initialize(x,y, parent)
    @x = x
    @y = y
    @parent = parent
    @distance = 0
  end
end

# if number of 1 in binary value is
# odd then it is a wall
def is_wall?(x,y)
  val = x * x + 3 * x + 2 * x * y + y + y * y + $fav_num
  oneCount = val.to_s(2).count("1")
  oneCount % 2 == 0 ? false : true
end

#
# find path: Modified Depth First Search
# to find all locations within a range
#
def find_path(startLoc, stepRange)
  # initialize the open set
  # to the starting position
  stack = Array.new
  stack.push(startLoc)

  while stack.length  > 0
    currentLoc = stack.pop
    parentLoc = currentLoc.parent
    if !parentLoc.nil?
      currentLoc.distance = parentLoc.distance + 1
    end
    if currentLoc.distance <= stepRange
      # mark as within range
      $visited[currentLoc.asString]=currentLoc
      # get the possible locations
      # we can traverse from here
      neighbors = generateAllNeighbors(currentLoc)
      neighbors.each { |n|
        if parentLoc.nil? || parentLoc.asString != n.asString
          stack.push(n)
        end
      }
    end
  end
end

def generateAllNeighbors(loc)
  neighbors = Array.new
  # east
  n = generateMazeLocation(loc.x + 1, loc.y, loc, neighbors)
  # south
  n = generateMazeLocation(loc.x, loc.y - 1, loc, neighbors)
  # west
  n = generateMazeLocation(loc.x - 1, loc.y, loc, neighbors)
  # north
  n = generateMazeLocation(loc.x, loc.y + 1, loc, neighbors)
  neighbors
end

def generateMazeLocation(x, y, parent, neighbors)
  mLoc = MazeLocation.new(x, y, parent)
  if accessible?(mLoc) && mLoc.asString != parent.asString
    neighbors.push(mLoc)
  end
end

def accessible?(loc)
  if loc.x < 0 || loc.y < 0
    return false
  end
  if is_wall?(loc.x, loc.y)
    return false
  end
  return true
end

$fav_num = 1364
$visited = Hash.new
start = MazeLocation.new(1,1, nil)
find_path(start, 50)
puts("total locations = #{$visited.length}")

m = make_maze(100,100)
$visited.each {|k,v|
  v = $visited.fetch(k)
  m[v.x][v.y] =  "O"
}
m[1][1]="S"
draw_maze(m)