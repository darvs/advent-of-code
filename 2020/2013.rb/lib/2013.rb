# frozen_string_literal: true

# Bus
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
    #puts ["timestamp, buses #{@timestamp}, #{@buses}"]
    list = @buses.map{|n| [n, n + (n * (@timestamp / n)) - @timestamp]}
                 .sort_by{|_, wait| wait}
    #puts list.to_s
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

  def run
    cycle, offset = @buses.first

    #puts "[cycle length] [#{cycle}] buses #{@buses}"

    find_next(0, cycle, @buses.drop(1)) - offset
  end

  def find_next(current, cycle, list)
    return current if list.empty?

    bus_cycle, delay = list.first

    current += cycle while (current + delay) % bus_cycle != 0

    find_next(current, cycle.lcm(bus_cycle), list.drop(1))
  end
end
