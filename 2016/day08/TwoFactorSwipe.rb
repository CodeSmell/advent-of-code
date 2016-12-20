require_relative '../day13/MakeMaze'

def fill(a, xNum, yNum)
  (0..xNum - 1).each do |x|
    (0..yNum - 1).each do |y|
      a[x][y] = "#"
    end
  end
end

def shiftColumn(a, x, shift)
  max_y = (a[0].length - 1)
  (1..shift).each do |idx|
    (1..max_y).each do |y|
      temp = a[x][y]
      a[x][y] = a[x][0]
      a[x][0] = temp
    end
  end
end

def shiftRow(a, y, shift)
  max_x = (a.length - 1)
  (1..shift).each do |idx|
    (1..max_x).each do |x|
      temp = a[x][y]
      a[x][y] = a[0][y]
      a[0][y] = temp
    end
  end
end

def doCommand(screen, cmd)
  skip = 1
  case cmd[0..3]
  when "rect"
    matcher = cmd.match(/rect (.+)x(.+)/)
    fill(screen, matcher[1].to_i, matcher[2].to_i)
  when "rota"
    matcher = cmd.match(/rotate (row|column) (.)=(.+) by (.+)/)
    if matcher[2] == 'x'
      shiftColumn(screen, matcher[3].to_i, matcher[4].to_i)
    else
      shiftRow(screen, matcher[3].to_i, matcher[4].to_i)
    end
  end
  return skip
end

#
# test case for 7x3 screen
#
def test_cmds(cmds)
  max_x = 7
  max_y = 3
  cmds.push("rect 3x2")
  cmds.push("rotate column x=1 by 1")
  cmds.push("rotate row y=0 by 4")
  cmds.push("rotate column x=1 by 1")
  screen = Array.new(max_x) { |i| Array.new(max_y) { |i| "." }}
end

def sysin_cmds(cmds)
  max_x = 50
  max_y = 6
  print('Enter the cmds:')
  $stdin.each do |user_input|
    # have a way to indicate
    # we are done entering commands
    if user_input.chomp == 'DONE'
      break
    end
    cmds.push(user_input.chomp)
  end
  screen = Array.new(max_x) { |i| Array.new(max_y) { |i| "." }}
end

cmds=Array.new
#screen = test_cmds(cmds)
screen = sysin_cmds(cmds)

nextCmd = 0
while (nextCmd < cmds.length)
  cmd = cmds[nextCmd]
  nextCmd = nextCmd + doCommand(screen, cmd)
end

def lit_up_count(a)
  count = 0
  max_x = a.length
  max_y = a[0].length
  (0..max_x - 1).each do |x|
    (0..max_y - 1).each do |y|
      count = (a[x][y]=="#" ? count + 1 : count)
    end
  end
  count
end

puts("the number of pixels that are lit up is #{lit_up_count(screen)}")
draw_maze(screen)
