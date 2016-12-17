def make_maze(max_x, max_y)
  maze = Array.new(max_x) { |i| Array.new(max_y) { |i| "." }}
  (0..max_x - 1).each do |x|
    (0..max_y - 1).each do |y|
      maze[x][y]=  is_wall?(x,y) ? "#" : "."
    end
  end
  maze
end

def draw_maze(a)
  max_x = a.length
  max_y = a[0].length
  (0..max_y - 1).each do |y|
    line = ""
    (0..max_x - 1).each do |x|
      line = line + a[x][y]
    end
    puts(line)
  end
end