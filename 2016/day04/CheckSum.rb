class RoomName
  attr_reader :seqNumber
  attr_reader :checkSumProvided
  #  encrypted name (lowercase letters separated by dashes)
  # followed by a dash, a sector ID,
  # and a checksum in square brackets.
  # sample encrypt name: aaaaa-bbb-z-y-x-123[abxyz]
  def initialize(encryptName)
    @encryptName = encryptName
    matches = encryptName.match(/(.*)(-)(\d*)(\[.*\])/)
    @value = matches[1]
    @seqNumber = matches[3].to_i
    @checkSumProvided = matches[4]
  end

  # generate a check sum 
  # based on the value 
  def checkSum
    h = Hash.new
    # get the counts of each character
    (0..@value.length - 1).each do |idx|
      char = @value[idx]
      h[char] = h.fetch(char,0) + 1
    end
    h.delete("-")
    h.sort_by{|k,v| [-v,k]}.to_h.keys.join[0..4]
  end

  # cmp the generated check sum
  # with the provided check sum
  def isValid?
    "[" + checkSum + "]" == @checkSumProvided
  end

  # decrypt the value using the sequence number
  def decrypt
    decryptedValue = ""
    shift = @seqNumber % 26
    (0..@value.length - 1).each do |idx|
      if @value[idx] == "-"
        decryptedValue = decryptedValue + " "
      else
        decryptedValue = decryptedValue + nextLetter(@value[idx], shift)
      end
    end
    return decryptedValue
  end

  private
  def nextLetter(char, shift)
    x= shift.times.inject(char) { |s| s.next }
    x[x.length - 1]
  end
end

total = 0
northPoleSeqNum = 0
print('Enter the values:')
$stdin.each do |user_input|
  # have a way to indicate
  # we are done entering commands
  if user_input.chomp == 'DONE'
    break
  end

  obj = RoomName.new(user_input)
  # part 1
  total = total + (obj.isValid? ? obj.seqNumber : 0)
  # part 2
  northPoleSeqNum = (obj.isValid? && obj.decrypt.include?("northpole")) ? obj.seqNumber : northPoleSeqNum
end
puts("the sequence number total: #{total}")
puts("the north pole sequence number: #{northPoleSeqNum}")