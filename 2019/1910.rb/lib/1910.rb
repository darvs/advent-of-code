# frozen_string_literal: true

# A simple Pair class
class Pair
  include Comparable
  attr_reader :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end

  def -(other)
    self.class.new(@x - other.x, @y - other.y)
  end

  def to_s
    "(#{@x}, #{@y})"
  end

  def to_str
    to_s
  end

  def inspect
    to_s
  end

  def ==(other)
    (@x == other.x) && (@y == other.y)
  end
end

# A simple Point class
class Point < Pair
  def manhattan_distance(other)
    (other.x - @x).abs + (other.y - @y).abs
  end
end

# A simple Fraction class where the fraction is simplified on construct
class Fraction < Pair
  include Comparable
  def initialize(numerator, denominator)
    gcd = numerator.gcd(denominator)
    gcd = 1 if gcd.zero?

    @x = numerator / gcd
    @y = denominator / gcd
  end

  def self.from_pair(pair)
    new(pair.x, pair.y)
  end

  def to_s
    "#{@x}/#{@y}"
  end
end

# A field of many asteroids
class Asteroids
  attr_reader :most_detected, :best_position

  def initialize(lines)
    @pos = parse(lines)

    @best_position, @most_detected = @pos.map{|pos| [pos, see_from(pos)]}
                                         .max_by{|_, seen| seen}
    @order = []
  end

  def parse(lines)
    lines.each_with_index.map{|line, lineno|
      line.chars.each_with_index.map{|c, pos| [c, pos]}
          .select{|c, _| c == '#'}
          .map{|_, pos| Point.new(pos, lineno)}
    }.flatten(1)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip))
  end

  def see_from(origin)
    @pos.reject{|other| other == origin}.map{|pt|
      Fraction.from_pair(pt - origin)
    }.map(&:to_s).sort.uniq.count
  end

  def blast
    origin = @best_position
    list = @pos.reject{|other| other == origin}.map{|pt|
      diff = pt - origin
      [pt, pt.manhattan_distance(origin),
       (Math.atan2(-diff.y, -diff.x) - Math::PI / 2) % (2 * Math::PI)]
    }

    sorted = list.sort_by{|_, distance, angle| [angle, distance]}

    occ = Hash.new(0)
    @order = sorted.map{|pt, distance, angle|
      rotation = occ[angle]
      occ[angle] += 1
      [pt, distance, angle + (rotation * (2 * Math::PI))]
    }.sort_by{|_, distance, angle| [angle, distance]}
  end

  def blasted(int)
    @order[int - 1].first
  end
end
