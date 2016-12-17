class Disk
  attr_reader :totalPos
  
  def initialize(startPos,totalPos)
    @startPos = startPos
    @totalPos = totalPos
  end

  # get disk position at a given time range
  # based on the disk total positions
  # and its starting position at t=0
  def diskPositionAtTime(t)
    (@startPos + t) % @totalPos
  end
end

def dropTheBall(t)
  # takes 1 sec to reach disk 1
  t = t + 1
  # all disks should be in position 0
  diskSlots = 0
  (0..$theDisks.length - 1).each do |diskNum|
    newPos = $theDisks[diskNum].diskPositionAtTime(t + diskNum)
    diskSlots = diskSlots + newPos 
    puts("Disk #{diskNum} at time #{t} is at #{newPos}")
  end
  diskSlots
end

$theDisks = Array.new
#Disc #1 has 17 positions; at time=0, it is at position 5.
$theDisks[0] = Disk.new(5, 17)
#Disc #2 has 19 positions; at time=0, it is at position 8.
$theDisks[1] = Disk.new(8, 19)
#Disc #3 has 7 positions; at time=0, it is at position 1.
$theDisks[2] = Disk.new(1, 7)
#Disc #4 has 13 positions; at time=0, it is at position 7.
$theDisks[3] = Disk.new(7, 13)
#Disc #5 has 5 positions; at time=0, it is at position 1.
$theDisks[4] = Disk.new(1, 5)
#Disc #6 has 3 positions; at time=0, it is at position 0.
$theDisks[5] = Disk.new(0, 3)
#NEW DISK has 11 positions; at time=0, it is at position 0.
$theDisks[6] = Disk.new(0, 11)

t=-1
diskSlots = -1
while diskSlots != 0
  t = t + 1
  diskSlots = dropTheBall(t)
  end
puts("press the button at t=#{t}")

