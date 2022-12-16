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

  def to_a
    [x, y]
  end

  # def ==(other)
  #   @x == other.x && @y == other.y
  # end
  #
  # def ===(other)
  #   @x == other.x && @y == other.y
  # end
  #

  def eql?(other)
    (@x == other.x) && (@y == other.y)
  end

  def hash
    to_s.hash
  end

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
    list.each{|line| parse_line(line)}

    @set.each{|p| puts p}
    puts '----------'
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

  # def top(pt)
  #   [pt[0], pt[1] - 1]
  # end
  #
  # def downleft(pt)
  #   [pt[0] - 1, pt[1] + 1]
  # end
  #
  # def downright(pt)
  #   [pt[0] + 1, pt[1] + 1]
  # end
  #

  def fall(pt, n = 0)
    puts "fallin #{pt}, #{n}"
    # What did we hit?
    hit = @set.select{|h| h.x == pt.x && h.y >= pt.y}

    # We're falling into the void!
    return n if hit.empty?

    # We've fallen on top of the one we hit
    fallen_to = hit.sort.first.top

    p "hit #{hit} fallen_to #{fallen_to}"

    p "fallen_to.down.left = #{fallen_to.down.left}, include? #{@set.include?(fallen_to.down.left)}"

    # Can we fall to the left?
    return fall(fallen_to.down.left, n) unless @set.include?(fallen_to.down.left)

    # Can we fall to the right?
    return fall(fallen_to.down.right, n) unless @set.include?(fallen_to.down.right)

    # Our fall has been stopped
    @set.add(fallen_to)
    p "new set: #{@set}"
    fall(Point.new(500, 0), n + 1)
  end

  def rest
    fall(Point.new(500, 0))
  end
end
