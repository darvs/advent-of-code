def parse(line)

  head = []
  tail = line.chars

  while tail.length > 0 do

    if head.length == 0 then
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

  stable = File.open(File.join('data', filename)).map(&:strip).select{|line| !line.empty?}
    .map{|line| parse(line)}.first

  return stable

end
