require_relative '../../2015/day03_oop/location'
require_relative 'MakeMaze'

class MazeLocation < Location
  attr_reader :parent
  def initialize(x,y, parent)
    @x = x
    @y = y
    @parent = parent
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
# find path: Breadth First Search
# finds a shortest path
# maze can be unbounded
# https://en.wikipedia.org/wiki/Breadth-first_search
# http://web.mit.edu/eranki/www/tutorials/search/
#
def find_path(startLoc, goalLoc)
  # initialize the open set
  # to the starting position
  # note: having this as array
  # caused issues since acted as stack
  queue = Queue.new
  queue.push(startLoc)

  while queue.length  > 0
    currentLoc = queue.pop
    # mark as visited
    $visited[currentLoc.asString]=currentLoc
    # get the possible locations
    # we can traverse from here
    neighbors = generateAllNeighbors(currentLoc)
    neighbors.each { |n|
      if n.x == goalLoc.x && n.y == goalLoc.y
        $visited[n.asString]=n
        break
      else
        queue.push(n)
      end
    }
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
  if accessible?(mLoc)
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
  if $visited[loc.asString]
    return false
  end
  return true
end

$fav_num = 1364
$visited = Hash.new
start = MazeLocation.new(1,1, nil)
goal = MazeLocation.new(31,39, nil)
find_path(start, goal)

# get the goal location
node = $visited.fetch(goal.asString)

# find the shortest path
# walk the parents back to the starting location
shortPath = Array.new
while !node.parent.nil?
  shortPath.push("#{$visited.fetch(node.parent.asString).asString}")
  node = node.parent
end
puts("shortest path was #{shortPath.length} steps")

m = make_maze(50,50)
shortPath.each {|path|
  loc = $visited.fetch(path)
  m[loc.x][loc.y] =  "O"
}
m[1][1]="S"
m[31][39]="G"
draw_maze(m)