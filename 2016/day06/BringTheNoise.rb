#
# initially collects data using the letter as the key
# with an array that counts occurrences based on the position
# that the letter was found
#
$alpha = Hash.new

def processTheNoise(line)
  (0..line.length() - 1).each do |idx|
    char = line[idx]
    countArray = $alpha.fetch(char, Array.new(line.length){ |i| 0 })
    countArray[idx] = countArray[idx] + 1
    $alpha[char] = countArray
  end
end

def determineTheSignal(checker)
  phrase = Array.new
  phraseCount = Array.new

  $alpha.keys.each do |k|
    countArray = $alpha[k]
    (0..countArray.length - 1).each do |idx|
      if phrase[idx].nil?
        phrase[idx] = k
        phraseCount[idx] = countArray[idx]
      elsif checker.call(countArray[idx], phraseCount[idx])
        phrase[idx] = k
        phraseCount[idx] = countArray[idx]
      end
    end
  end
  return phrase.join
end

print('Enter the values:')
$stdin.each do |user_input|
  # have a way to indicate
  # we are done entering commands
  if user_input.chomp == 'DONE'
    break
  end
  processTheNoise(user_input.chomp)
end
puts("the decoded message: #{determineTheSignal(lambda{|x, y| x > y})}")
puts("the decoded message: #{determineTheSignal(lambda{|x, y| x < y})}")