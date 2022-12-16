# frozen_string_literal: true

class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def down
    Point.new(@x, @y + 1)
  end

  def top
    Point.new(@x, @y - 1)
  end

  def right
    Point.new(@x + 1, @y)
  end

  def left
    Point.new(@x - 1, @y)
  end

  def to_s
    "p[#{x},#{y}]"
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

# The Regolith
class Regolith
  def initialize(list)
    @set = Set.new
    @floor = nil
    @start = Point.new(500, 0)

    list.each{|line| parse_line(line)}

    #@set.each{|p| puts p}
    #puts '----------'
  end

  def parse_line(string)
    points = string.split(' -> ').map{|pair_string|
      pair_string.split(',').map(&:to_i)
    }

    #p "points #{points}"

    a = points.shift
    until points.empty?
      b = points.shift
      xx = [a[0], b[0]]
      yy = [a[1], b[1]]
      (xx.min..xx.max).each{|x|
        (yy.min..yy.max).each{|y|
          @set.add(Point.new(x, y))
        }
      }
      a = b
    end
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:chomp))
  end

  def fall(pt)
    #puts "fallin #{pt}"

    return false if @set.include?(@start)
    #return false if pt.y.negative?

    # Fake the floor around where we're falling
    unless @floor.nil?
      (pt.x - 1..pt.x + 1).each{|x|
        @set.add(Point.new(x, @floor))
      }
    end

    # What did we hit?
    hit = @set.select{|h| h.x == pt.x && h.y >= pt.y}&.min

    return false if hit.nil?

    # We've fallen on top of the one we hit
    #fallen_to = hit.top

    # Can we fall to the left?
    down_left = hit.left
    return fall(hit.left) unless @set.include?(down_left)

    # Can we fall to the right?
    down_right = hit.right
    return fall(down_right) unless @set.include?(down_right)

    # Our fall has been stopped by the one we hit
    @set.add(hit.top)

    true
  end

  def debug
    min_x = @set.map(&:x).min
    max_x = @set.map(&:x).max
    min_y = @set.map(&:y).min
    max_y = @set.map(&:y).max

    d = (min_y..max_y).map{|y|
      (min_x..max_x).map{|x|
        @set.include?(Point.new(x, y)) ? '#' : '.'
      }.reduce(&:+)
    }
    d.each{|line| puts line}
  end

  def rest
    0.step{|n| return n unless fall(@start)}
  end

  def fill
    @floor = @set.map(&:y).max + 2
    # p "floor is #{@floor}"

    start_time = Time.now
    last_time = start_time

    y = 0.step{|n|
      break n unless fall(@start)}
    # p "answer is #{y}"
    #debug
    y
  end
end
