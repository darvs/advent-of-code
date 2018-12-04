def spin(programs, spin_size)
  programs.rotate!(-spin_size)
end

def exchange(programs, a, b)
  tmp = programs[a]
  programs[a] = programs[b]
  programs[b] = tmp
end

def partner(programs, a, b)
  pos_a = programs.index(a)
  pos_b = programs.index(b)
  exchange(programs, pos_a, pos_b)
end

def dance(programs, move)
  case move['cmd']
  when 's'
    spin(programs, move['p1'].to_i)
  when 'x'
    exchange(programs, move['p1'].to_i, move['p2'].to_i)
  when 'p'
    partner(programs, move['p1'], move['p2'])
  end
end

def parse(str)
  # Sample format :  #1 @ 1,3: 4x4
  regexp = Regexp.union(
    /(?<cmd>[a-z])(?<p1>\w+)(\/(?<p2>\w+))?/
  )

  #print "STR #{str} "
  #print "SCAN #{str.scan(regexp)}\n"

  return str.scan(regexp).map{|match|
    Hash[regexp.names.zip(match)]
  }.first
end

def exec_file(filename, programs_str, times)

  moves = File.open(File.join('data', filename)).map(&:strip).select{|line| !line.empty?}
    .map{|l| l.lines(",")}
    .flatten
    .map{|l| l.chomp(',')}
    .map{|str| parse(str)}

  programs = programs_str.chars
  seen = [programs_str]

  for _ in (1 .. times)
    moves.each{|move| dance(programs, move)}

    if seen.index(programs.join) != nil then
      puts "There is a loop in the values and it's #{seen.length} moves long"

      # After looping (times div seen.length),
      # we'd still need to dance (times mod seen.length) moves
      # to dance a total of "times" dance moves.

      # For instance, if we had to dance 136 moves, with a loop length of 60,
      # We would have gone through the loop twice (136 div 60 = 2), and then
      # we would have danced the 16 first steps of the loop again (136 % 60 = 16)
      # and so, after the 136th, we would have been in exactly the same position
      # as after the 16th move.

      final = seen[times % seen.length]
      break
    end

    final = programs.join
    puts "Pushing # #{seen.length} : #{final}"
    seen.push(final)
  end

  return final
end
