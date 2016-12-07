# a different look at the problem
#
# initially collects data using the position as the key
# with a hash that has the letter as the key
# and a value that is a simple counter
#
$h = Hash.new

def processTheNoise(line)
  (0..line.length() - 1).each do |position|
    char = line[position]
    charHash = $h.fetch(position, {char => 0})
    charHash[char] = charHash.fetch(char, 0) + 1
    $h[position] = charHash
  end
end

def determineTheSignal
  return $h.collect{|k,v| v.sort_by{|k,v| -v}.to_h.keys.first}.join
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

$h.keys.each do |k|
  puts "position #{k} has #{$h[k]}"
end

puts("the decoded message: #{determineTheSignal}")
# TODO:part2