$registers=Hash.new
$registers["a"]=0
$registers["b"]=0
$registers["c"]=1
$registers["d"]=0

def is_numeric?(obj)
  obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
end

def copy(x, y)
  if is_numeric?(x)
    $registers[y]=x.to_i
  else
    $registers[y]=$registers.fetch(x)
  end
end

def inc(x)
  $registers[x]=$registers.fetch(x) + 1
end

def dec(x)
  $registers[x]=$registers.fetch(x) - 1
end

def jnz(x, y)
  if (is_numeric?(x)? x : $registers.fetch(x)) != 0
    return y.to_i
  end
  return 0
end

cmds=Array.new
cmds.push("cpy 1 a")
cmds.push("cpy 1 b")
cmds.push("cpy 26 d")
cmds.push("jnz c 2")
cmds.push("jnz 1 5")
cmds.push("cpy 7 c")
cmds.push("inc d")
cmds.push("dec c")
cmds.push("jnz c -2")
cmds.push("cpy a c")
cmds.push("inc a")
cmds.push("dec b")
cmds.push("jnz b -2")
cmds.push("cpy c b")
cmds.push("dec d")
cmds.push("jnz d -6")
cmds.push("cpy 19 c")
cmds.push("cpy 14 d")
cmds.push("inc a")
cmds.push("dec d")
cmds.push("jnz d -2")
cmds.push("dec c")
cmds.push("jnz c -5")

def doCommand(cmd)
  skip = 1
  case cmd[0..2]
  when "cpy"
    matcher = cmd.match(/cpy (.+) (.+)/)
    copy(matcher[1], matcher[2])
  when "inc"
    matcher = cmd.match(/inc (.+)/)
    inc(matcher[1])
  when "dec"
    matcher = cmd.match(/dec (.+)/)
    dec(matcher[1])
  when "jnz"
    matcher = cmd.match(/jnz (.+) (.+)/)
    skip = jnz(matcher[1], matcher[2])
    skip = (skip == 0 ? 1 : skip)
  end
  return skip
end

nextCmd = 0
while (nextCmd < cmds.length)
  cmd = cmds[nextCmd]
  nextCmd = nextCmd + doCommand(cmd)
end

puts('*** The Registers ***')
$registers.keys.each do |k|
  puts("#{k} = #{$registers[k]}")
end
