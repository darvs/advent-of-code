# frozen_string_literal: true

# Program
class Program
  def initialize(list)
    @resonance = false
    @antenna = Hash.new([])
    @antinode = Set.new

    list.each.with_index{|line, y|
      line.each_char.with_index{|char, x|
        @antenna[char] += [[x, y]] unless char == '.'
      }
    }
    @max_y = list.length - 1
    @max_x = list[0].length - 1
    p "max x,y #{@max_x},#{@max_y} antenna #{@antenna}"
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def add_resonance
    @resonance = true
  end

  def run
    @antenna.each_key{|k|
      p "combo #{k}"
      @antenna[k].combination(2).each{|pair|
        a, b = *pair
        #p "  a, b #{a}, #{b}"
        add_points(a, b)
      }
    }
    p "antinode #{@antinode}"
    @antinode.length
  end

  def add_points(a, b)
    dx = a[0] - b[0]
    dy = a[1] - b[1]

    add_one_point(a[0], a[1], dx, dy)
    add_one_point(b[0], b[1], -dx, -dy)
  end

  def add_one_point(x0, y0, dx, dy)
    @antinode.add([x0, y0]) if @resonance

    x = x0 + dx
    y = y0 + dy

    loop do
      return unless valid_point(x, y)

      #p "    add #{x},#{y}"
      @antinode.add([x, y])

      return unless @resonance

      x += dx
      y += dy
    end
  end

  def valid_point(x, y)
    return false if x.negative?
    return false if x > @max_x
    return false if y.negative?
    return false if y > @max_y

    true
  end
end
