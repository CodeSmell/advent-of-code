require 'digest'

$md5 = Digest::MD5.new

class Room
  attr_reader :doorId
  attr_reader :index
  attr_reader :digest
  def initialize(doorId, index, digest)
    @doorId = doorId
    @index = index
    @digest = digest
  end
end

def generateNextValidDigest(doorId, startingIndex)
  theValidDigest = ""
  idx = startingIndex + 1
  while (theValidDigest.length == 0)
    myValue = doorId + idx.to_s
    digest = $md5.hexdigest myValue
    if digest.to_s.start_with?('00000')
      puts("**** index: #{idx} and digest #{digest}")
      theValidDigest = digest.to_s
    end
    idx = idx + 1
  end
  return Room.new(doorId,idx,theValidDigest)
end

def doorNumberOne(doorId)
  idx = -1
  password = ""
  while (password.length < 8)
    room = generateNextValidDigest(doorId, idx)
    password = password + room.digest[5]
    idx = room.index
  end
  return password
end

def doorNumberTwo(doorId)
  numFound = 0
  password = Array.new(8)
  idx = -1
  while (numFound < 8)
    room = generateNextValidDigest(doorId, idx)
    sixthChar = room.digest[5]
    position = (is_integer?(sixthChar) ? sixthChar.to_i : -1)
    if (position >= 0 && position <= 7)
      if (password[position].nil?)
        puts("**** position: #{position} and digest char: #{room.digest[6]}")
        numFound = numFound + 1
        password[position] = room.digest[6]
      end
    end
    idx = room.index
  end 
  return password.join
end

def is_integer?(s)
  s.to_i.to_s == s
end

#puts("the password for door #1 is #{doorNumberOne('wtnhxymk')}")
puts("the password for door #2 is #{doorNumberTwo('wtnhxymk')}")