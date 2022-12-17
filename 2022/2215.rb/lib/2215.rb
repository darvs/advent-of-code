# frozen_string_literal: true

# A Point, any point
class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def manhattan_distance(other)
    (@x - other.x).abs + (@y - other.y).abs
  end

  def to_s
    "[#{x},#{y}]"
  end

  def inspect
    to_s
  end

  # eql? and hash are used to see if an item is in a Set
  def eql?(other)
    (@x == other.x) && (@y == other.y)
  end

  def hash
    to_s.hash
  end

  # the spaceship operator is used to sort the Set
  def <=>(other)
    cmp_x = (@x <=> other.x)
    return cmp_x unless cmp_x.zero?

    @y <=> other.y
  end
end

# One Sensor
class Sensor
  attr_reader :range

  def initialize(sensor_loc, bacon_loc)
    @sensor = sensor_loc
    @bacon = bacon_loc
    @range = sensor_loc.manhattan_distance(bacon_loc)
  end

  def to_s
    "(s #{@sensor} b #{@bacon} r #{@range})"
  end

  def inspect
    to_s
  end
end

class Ranges
  def initialize
    @parts = []
  end

  def union(pair)
    if @parts.empty?
      @parts = [pair]
      return
    end

    @parts.append(pair).sort!
    simplify
  end

  def simplify
    # Already pretty simple
    return if @parts.length <= 1

    processed = []
    current = @parts.shift

    until @parts.empty?
      second = @parts.shift

      # overlap
      if second[0] < current[1] + 1
        current = [[current[0], second[0]].min, [current[1], second[1]].max]
      else
        processed.append(current)
        current = second
      end
    end

    @parts = processed.append(current)
  end

  def difference(pair)
    return if @parts.empty?

    p "differences #{@parts} - #{pair}"

    processed = []
    @parts.each{|current|
      # pair was before current
      if pair[1] < current[0]
        processed.append(current)

      # pair is after current
      elsif pair[0] > current[1]
        processed.append(current)

      # pair encompasses current
      elsif pair[0] <= current[0] && pair[1] >= current[1]
        # forget current

      # intersection at the beginning
      elsif pair[0] <= current[0] && pair[1] < current[1]
        processed.append([pair[1] + 1, current[1]])

      # intersection at the end
      elsif pair[0] > current[0] && pair[1] >= current[1]
        processed.append([current[0], pair[0] - 1])

      # must be split
      else
        processed.append([current[0], pair[0] - 1])
        processed.append([pair[1] + 1, current[1]])
      end
    }
    @parts = processed

    p "differences end #{@parts}"
  end

  def coverage
    @parts.map{|x, y| (y - x).abs + 1}.sum
  end

  def to_s
    @parts.map{|a, z| "[#{a},#{z}]"}.join(', ')
  end

  def inspect
    to_s
  end
end

# Beacons Exclusion Zone
class AllBeacons
  def initialize(list)
    @bacons = Set.new
    @sensors = {}
    list.each{|line| parse(line)}
    p @bacons
    p @sensors
  end

  def parse(line)
    match = /Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/.match(line)
    sx, sy, bx, by = match.captures

    bacon_loc = Point.new(bx.to_i, by.to_i)
    sensor_loc = Point.new(sx.to_i, sy.to_i)

    @bacons.add(bacon_loc)
    @sensors[sensor_loc] = Sensor.new(sensor_loc, bacon_loc)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:chomp))
  end

  # Number of spaces where a beacon cannot be present on row(n)
  def row(r)
    # coverage = Set.new
    ranges = Ranges.new
    @sensors.sort.each{|loc, sen|
      range_at_r = sen.range - (loc.y - r).abs
      if range_at_r >= 0
        # (0..range_at_r).each{|n|
        #   coverage.add(Point.new(loc.x - n, r))
        #   coverage.add(Point.new(loc.x + n, r))
        # }
        #
        ranges.union([loc.x - range_at_r, loc.x + range_at_r])
      end
    }

    p "ranges before difference #{ranges}"

    @bacons.filter{|b| b.y == r}.each{|b|
      #coverage.delete(b)
      ranges.difference([b.x, b.x])
    }

    @sensors.filter{|k, _| k.y == r}.each_key{|s|
      #coverage.delete(s)
      ranges.difference([s.x, s.x])
    }

    #p "coverage #{coverage}"
    p "ranges #{ranges}"
    p "ranges coverage #{ranges.coverage}"

    #coverage.length
    ranges.coverage
  end
end
