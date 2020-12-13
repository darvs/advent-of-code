# frozen_string_literal: true

# Manhattan
class Bus
  def initialize(list)
    @timestamp, @buses = parse(list)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end
end

# Bus for part1
class Bus1 < Bus
  def parse(lines)
    [lines[0].to_i, lines[1].split(',').reject{|x| x == 'x'}.map(&:to_i)]
  end

  def run
    puts ["timestamp, buses #{@timestamp}, #{@buses}"]
    list = @buses.map{|n| [n, n + (n * (@timestamp / n)) - @timestamp]}
                 .sort_by{|_, wait| wait}
    puts list.to_s
    list[0][0] * list[0][1]
  end
end

# Bus for part2
class Bus2 < Bus
  def parse(lines)
    [lines[0], lines[1].split(',').map.with_index(0){|x, i| [x, i]}
                       .reject{|x, _| x == 'x'}
                       .map{|x, i| [x.to_i, i.to_i]}]
  end

  def run_from(start)
    puts ["buses #{@buses}"]

    # We'll adjust the start so that it fits a multiple of the base
    @buses = @buses.sort_by{|n, _| n}.reverse
    base = @buses[0][0]

    bus0 = @buses[0][0]
    start += bus0 - (start % bus0)

    offset = @buses[0][1]
    @buses = @buses[1..-1]

    puts "base, buses #{base}, #{@buses}"

    while true
      #puts start
      break if @buses.all?{|x, i|
         #puts x
         (start + i - offset) % x == 0
      }
      start += base
    end

    start - offset
  end
end
