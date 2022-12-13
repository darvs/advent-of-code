# frozen_string_literal: true

# A Point on the Map
class Point
  attr_reader :height, :x, :y, :symbol

  attr_accessor :manhattan_distance

  def initialize(y, x, symbol)
    @y = y
    @x = x
    @symbol = symbol
    @height = symbol == 'S' ? 0 : 'abcdefghijklmnopqrstuvwxyzE'.index(symbol)
    @shortest_path = nil
    @manhattan_distance = 0
  end

  def is_shortest_path?(d)
    if @shortest_path.nil? || @shortest_path > d
      @shortest_path = d
      return true
    end

    false
  end

  def to_s
    #"Point h #{@height} d #{@shortest_path}"
    "(#{symbol} #{y},#{x}, (md #{@manhattan_distance}))"
  end
end

# A Collection of Some Points
class SomePoints
  attr_reader :summit, :points

  def initialize
    @points = Hash.new(nil)
    @summit = nil
  end

  def add(y, x, symbol)
    p = Point.new(y, x, symbol)
    @points[[y, x]] = p

    if symbol == 'E'
      p "Summit is #{p}"
      @summit = p
      p.manhattan_distance = 0
    else
      p.manhattan_distance = (p.x - @summit.x).abs + (p.y - @summit.y).abs
    end
  end

  def main_start
    main = @points.filter{|_, p|
      p.symbol == 'S'}.map{|_, p| p}.first

    p "main: #{main}"
    main
  end
end

# A Singer
class KateBush
  def initialize(list)
    @start = []

    @all = SomePoints.new

    #@current = []
    @all_starts = []

    @map = Hash.new{nil}
    parse(list)

    @map_w = list[0].length 
    @map_h = list.length

    @shortest_path = nil
  end

  def parse(list)
    # Mark summit first

    points = list.each_with_index.map{|line, y|
      line.chars.each_with_index.map{|sym, x|
        [y, x, sym]
      }
    }.flatten(1)

    #p "points #{points}"

    # First find the summit
    summit, others = points.partition{|_, _, sym| sym == 'E'}

    # Create the summit
    summit.map{|y, x, sym| @all.add(y, x, sym)}

    # Create the others
    others.map{|y, x, sym| @all.add(y, x, sym)}

    #p "all #{@all.points}"

  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:chomp))
  end

  def debug
    p self
    p @list
  end

  def valid_direction(y, x, h, path_set)
    return nil unless x.between?(0, @map_w - 1)
    return nil unless y.between?(0, @map_h - 1)
    #p "x #{x}/#{@map_w} y #{y}"
    return nil unless @all.points[[y, x]].height <= h + 1

    # Do we already have a successful shorter path?
    return nil if !@shortest_path.nil? && (path_set.length >= @shortest_path)

    # Did we already visit that point?
    return nil if path_set.include?([y, x])

    # Abandon if we already have a shorter path to this point
    return nil unless @all.points[[y, x]].is_shortest_path?(path_set.length)

    @all.points[[y, x]]
  end

  def next_directions(y, x, h, path_set)
    [valid_direction(y, x + 1, h, path_set),
     valid_direction(y + 1, x, h, path_set),
     valid_direction(y - 1, x, h, path_set),
     valid_direction(y, x - 1, h, path_set)]
      .reject(&:nil?)
      .sort{|a, b|
        h = (b.height <=> a.height)
        if !h.zero? then h
        else
          (a.manhattan_distance <=> b.manhattan_distance)
        end
      }
      # .sort{|a, b|
      #   h = (a.height <=> b.height)
      #   if h.zero? then (a.manhattan_distance <=> b.manhattan_distance) end
      #   h
      # }
  end

  def run(current, path)
    # p "run #{current} , #{path}"
    #p "map #{@map}"
    h = current.height

    if h == @all.summit.height
      p "Reached the top with path of length #{path.length}"
      @shortest_path = path.length if @shortest_path.nil? || path.length < @shortest_path
      return [path.length] # + 1 for current, -1 removes the origin
    end

    valid_next = next_directions(current.y, current.x, current.height, path.to_set)

    return [nil] if valid_next.empty?

    #p "v_n #{valid_next}"

    valid_next.map{|n|
      #p "#{current} -> #{n} : #{path.clone.prepend([current.y, current.x])}"
      run(n, path.clone.prepend(current))
    } #.reject(&:nil?).reject(&:empty?)
  end

  def running_up_that_hill
    @all.points.filter{|_, v| v.symbol == 'S'}.map{|_, v|
      p "Running for #{v}..."
      run(v, []).flatten.reject(&:nil?).min
    }.min
  end

  def running_up_all_hills
    @all.points.filter{|_, v| v.height.zero?}.map{|_, v| v}.sort{|a, b| a.manhattan_distance <=> b.manhattan_distance}.map{|v|
      p "Running for #{v}..."
      run(v, []).flatten.reject(&:nil?).min
    }.reject(&:nil?).min
  end
end
