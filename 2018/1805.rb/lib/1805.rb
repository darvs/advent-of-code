def parse(line, skip=nil)

  head = []
  tail = line.chars

  while tail.length > 0 do

    if !skip.nil? && skip.casecmp?(tail[0]) then
      tail.shift

    elsif head.length == 0 then
      head = [tail.shift]

    elsif head[-1].swapcase == tail[0] then
      head.pop
      tail.shift

    else
      head.concat([tail.shift])

    end

  end

  return head.join
end

def exec_file(filename)

  polymer = File.open(File.join('data', filename)).map(&:strip).select{|line| !line.empty?}.first

  stable = parse(polymer)

  filtering = [:unit, :len, :result].zip(('a'..'z').map{|c|
    result = parse(polymer, c)
    [c, result.length, result]
  }.min_by{|_, len, _| len}).to_h

  #puts "filtering #{filtering}"

  return stable, filtering

end
