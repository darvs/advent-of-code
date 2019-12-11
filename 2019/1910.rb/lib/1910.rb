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

  #def swap
    #Pair.new(@y, @x)
  #end

  #def <=>(other)
    #p [:alien, "#{@x},#{@y} <=> #{other.x},#{other.y}"]
    #return (@y <=> other.y) if (@x <=> other.x).zero?

    #@x <=> other.x
  #end

  #def eql?(other)
    #(@x == other.x) && (@y == other.y)
  #end
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
    if gcd == 0 then gcd = 1 end

    @x = numerator / gcd
    @y = denominator / gcd

    #if @x < 0 && @y < 0
      #@x = x.abs
      #@y = y.abs
    #end
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
  def initialize(lines)
    @pos = parse(lines)
    p [:pos, @pos]

    @max_seen = @pos.map{|pos| [pos, see_from(pos)]}.max_by{|_, seen| seen}
    @order = []
    p [:max_seen, @max_seen]
  end

  def parse(lines)
    lines.each_with_index.map{|line, lineno|
      line.chars.each_with_index.map{|c, pos| [c, pos]}
          .select{|c, _| c == '#'}
          .map{|_, pos| Point.new(pos, lineno)}
    }.flatten(1)
  end

  def self.read_file(filename)
    File.readlines(File.join('data', filename)).map(&:strip)
  end

  def self.from_file(filename)
    new(read_file(filename))
  end

  def see_from(origin)
    @pos.map{|pt| Fraction.from_pair(pt - origin)}
        .reject{|pt| pt.x.zero? && pt.y.zero?}
        .map(&:to_s).sort.uniq.count
  end

  def most_detected
    #p [:most_detected, @max_seen[1]]
    @max_seen[1]
  end

  def best_position
    #p [:best_position, @max_seen[0]]
    @max_seen[0]
  end

  def circular_sort(list)
    p :circular_sort
    top_right = list.select{|f| f.x >= 0 && f.y >= 0}.sort_by{|f| Math.atan(Float(f.y)/f.x)}.uniq{|cmp| [cmp.x, cmp.y]}
    #bottom_right = list.select{|f| f.x >= 0 && f.y < 0}.sort_by{|f| Float(f.y)/f.x}.uniq{|cmp| [cmp.x, cmp.y]}
    #bottom_left = list.select{|f| f.x < 0 && f.y < 0}.sort_by{|f| Float(f.y)/f.x}.uniq{|cmp| [cmp.x, cmp.y]}
    #top_left = list.select{|f| f.x < 0 && f.y >= 0}.sort_by{|f| Float(f.y)/f.x}.uniq{|cmp| [cmp.x, cmp.y]}
 

    p [:top_right, top_right]
    #p [:bottom_right, bottom_right]
    #p [:bottom_left, bottom_left]
    #p [:top_left, top_left]

    whole = top_right # + bottom_right + bottom_left + top_left
    #p whole
  end

  def blast
    #origin = best_position
    p [:blast, :max_seen, @max_seen]
    list = @pos.reject{|other| other.x == best_position.x && other.y == best_position.y}.map{|pt|
      diff_tmp = pt - best_position
      diff = Point.new(-diff_tmp.x, -diff_tmp.y)

      p [:best, best_position, :pt, pt, :diff, diff]

      [pt, pt.manhattan_distance(best_position), ((Math.atan2(diff.y, diff.x)) - Math::PI/2 ) % (2 * Math::PI)]
    }
#               .select{|_, _, atan| atan >= 0 && atan <= Math::PI / 2}

    p '---------------------'
    p :list
    list.each{|x| p x}
    p '---------------------'

    sorted = list.sort_by{|_, distance, angle| [angle, distance]}

    p [:sorted]
    sorted.each{|x| p x}

    occ = Hash.new(0)
    resorted = sorted.map{|pt, distance, angle|
      rotation = occ[angle]
      occ[angle] += 1
      [pt, distance, angle + (rotation * (2 * Math::PI))]
    }.sort_by{|_, distance, angle| [angle, distance]}

    p ['---------------------']
    p [:occ]
    p occ
    p [:resorted]
    resorted.each{|x| p [x, (x[2] / (2 * Math::PI)).floor]}

    #p circ=circular_sort(list.map{|_, _, fr| fr})
    #p ['-------------------']
  
    @order = resorted
  end

  def blasted(int)
    @order[int - 1].first
  end
end
