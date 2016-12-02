require_relative '../../2015/day03_oop/location'

class KeyPad
  attr_reader :keyPress
  def initialize(startingKey)
    @keyPad = Hash.new
    keyPadPart2
    @keyPress = ""
    @currentKey = startingKey
  end

  def move(dirChar)
    case dirChar
    when "U"
      doMove(Location.new(@currentKey.x, @currentKey.y + 1))
    when "R"
      doMove(Location.new(@currentKey.x + 1, @currentKey.y))
    when "L"
      doMove(Location.new(@currentKey.x - 1, @currentKey.y))
    when "D"
      doMove(Location.new(@currentKey.x, @currentKey.y - 1))
    end
    puts("now over button #{@currentKey.asString}")
  end

  def pressButton
    @keyPress += @keyPad[@currentKey.asString]
  end

  private

  def doMove(aLocation)
    if @keyPad[aLocation.asString]
      @currentKey = aLocation
    end
  end

  def keyPadPart1
    @keyPad[Location.new(-1,1).asString]="1"
    @keyPad[Location.new(-1,0).asString]="4"
    @keyPad[Location.new(-1,-1).asString]="7"

    @keyPad[Location.new(0,1).asString]="2"
    @keyPad[Location.new(0,0).asString]="5"
    @keyPad[Location.new(0,-1).asString]="8"

    @keyPad[Location.new(1,1).asString]="3"
    @keyPad[Location.new(1,0).asString]="6"
    @keyPad[Location.new(1,-1).asString]="9"
  end

  def keyPadPart2
    @keyPad[Location.new(2,2).asString]="1"

    @keyPad[Location.new(1,1).asString]="2"
    @keyPad[Location.new(2,1).asString]="3"
    @keyPad[Location.new(3,1).asString]="4"

    @keyPad[Location.new(0,0).asString]="5"
    @keyPad[Location.new(1,0).asString]="6"
    @keyPad[Location.new(2,0).asString]="7"
    @keyPad[Location.new(3,0).asString]="8"
    @keyPad[Location.new(4,0).asString]="9"

    @keyPad[Location.new(1,-1).asString]="A"
    @keyPad[Location.new(2,-1).asString]="B"
    @keyPad[Location.new(3,-1).asString]="C"

    @keyPad[Location.new(2,-2).asString]="D"
  end
end

# each line is a cmd sequence that
# precedes hitting the button on the key pad
keypad = KeyPad.new(Location.new(0,0))
print('Enter the command sequences:')
$stdin.each do |cmdSeq|
  # have a way to indicate
  # we are done entering commands
  if cmdSeq.chomp == 'ENTER'
    break
  end

  for i in 0..cmdSeq.chomp.length
    keypad.move(cmdSeq[i])
  end
  keypad.pressButton()
end
puts(keypad.keyPress)
