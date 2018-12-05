def parse(polymer)

  reduced = polymer.clone

  puts "reduced #{reduced}"
  STDOUT.flush

  while 1 do
    start = reduced.clone

    continue = true
    offset = 0
    puts "scan #{reduced} l-1 #{reduced.length-1}"
    STDOUT.flush
    while (continue == true) and (offset < reduced.length-1) do
      puts "meanwhile #{offset}"
      if reduced[offset+1] == reduced[offset].swapcase then
        puts "score #{reduced[offset]} #{reduced[offset+1]}"
        reduced.slice!(offset, 2)
        puts "reduced #{reduced}"
        continue = false
        break;
        offset = 255
      end
      #break if reduced == polymer
      offset = offset + 1
      STDOUT.flush
      #if offset > 5 then continue = false end
    end

    puts "cmp @#{offset} #{reduced} #{polymer}"
    STDOUT.flush
    break if reduced == start
  end

  #reduced.scan(/([A-Za-z])([A-Za-z])/).each{|pair| 
    #puts "pair #{pair[0]} , #{pair[1]}"
    #if pair[1] == pair[0].swapcase then 
      #puts "score #{pair[0]} , #{pair[1]}"
      #reduced.gsub!(pair[0],pair[1]) 
    #end}

  return reduced

  #if (reduced == polymer) then
    #return polymer
  #else
    #return parse(reduced)
  #end
end

def exec_file(filename)

  stable = File.open(File.join('data', filename)).map(&:strip).select{|line| !line.empty?}
    .map{|line| parse(line)}.first

  return stable

end
