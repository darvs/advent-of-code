def parse(line, skip = nil)
  head = []
  tail = line.chars

  until tail.empty?
    if !skip.nil? && skip.casecmp?(tail[0])
      tail.shift

    elsif head.empty?
      head = [tail.shift]

    elsif head[-1].swapcase == tail[0]
      head.pop
      tail.shift

    else
      head.concat([tail.shift])
    end
  end

  head.join
end

def exec_file(filename)
  polymer = File.open(File.join('data', filename)).map(&:strip)
                .reject(&:empty?).first

  stable = parse(polymer)

  filtering = %i[unit len result].zip(('a'..'z').map{|c|
    result = parse(polymer, c)
    [c, result.length, result]
  }
    .min_by{|_, len, _| len}).to_h

  #puts "filtering #{filtering}"

  [stable, filtering]
end
