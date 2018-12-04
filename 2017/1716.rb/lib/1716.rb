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

def exec_file(filename, programs, times)
  #puts "PROGRAMS:: #{programs}"

  moves = File.open(File.join('data', filename)).map(&:strip).select{|line| !line.empty?}
    .map{|l| l.lines(",")}
    .flatten
    .map{|l| l.chomp(',')}
    .map {|str| parse(str)}
  chars = programs.chars
  (1..times).each {
    moves.each{|move| dance(chars, move)}
  }

  #puts "CHARS:: #{chars}"
 
  #puts "FINAL PROGRAMS!:: #{programs}"

  return chars.join
end
