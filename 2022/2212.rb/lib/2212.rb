# frozen_string_literal: true

class Point
  attr_reader :height

  def initialize(height)
    @height = height
    @distance = nil
  end

  def check_distance(d)
    if @distance.nil? || @distance > d
      @distance = d
      return true
    end

    false
  end

  def to_s
    "Point h #{@height} d #{@distance}"
  end
end

# A Singer
class KateBush
  HIGH = 'SabcdefghijklmnopqrstuvwxyzE'

  def initialize(list)
    @top = HIGH.index('E')
    @start = []
    @end = []
    #@current = []
    @all_starts = []

    @map = Hash.new{nil}
    parse(list)

    @map_w = list[0].length 
    @map_h = list.length

    @distance = nil
  end

  def parse(list)
    list.each_with_index{|line, y|
      line.chars.each_with_index{|hi, x|
        #p "[#{x},#{y}] hi #{hi} li #{line}"
        if hi == 'S'
          @start = [y, x]
          #@current = @start
          @all_starts.append(@start)
        end

        @all_starts.append([y, x]) if hi == 'a'

        @end = [y, x] if hi == 'E'

        pt = Point.new(HIGH.index(hi))

        @map[[y, x]] = pt
        #p "setmap #{pt} #{@map[[y, x]]}"
      }
    }
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
    return nil unless @map[[y, x]].height <= h + 1

    # Do we already have a successful shorter path?
    return nil if (! @distance.nil?) && (path_set.length >= @distance)

    return nil if path_set.include?([y, x])

    return nil unless @map[[y, x]].check_distance(path_set.length)

    [y, x]
  end

  def next_directions(y, x, h, path_set)
    [valid_direction(y, x + 1, h, path_set),
     valid_direction(y + 1, x, h, path_set),
     valid_direction(y - 1, x, h, path_set),
     valid_direction(y, x - 1, h, path_set)]
      .reject(&:nil?)
      .sort{|a, b|
        #p "sort a #{a} b #{b}"
        if a.nil? then b
        elsif b.nil? then a
        else @map[a].height <=> @map[b].height end
      }
  end

  def run(current, path)
    #p "run #{current} , #{path}"
    #p "map #{@map}"
    y, x = current
    h = @map[[y, x]].height

    #return path.prepend(current) if h == @top
    if h == @top
      p "Reached the top with path of length #{path.length}"
      @distance = path.length if @distance.nil? || path.length < @distance
      return path.length # + 1 for current, -1 removes the origin
    end

    valid_next = next_directions(y, x, h, path.to_set)

    #return nil if valid_next.empty?
    return nil if valid_next.empty?

    #p "v_n #{valid_next}"

    valid_next.map{|n|
      #p "#{current} -> #{n} : #{path.clone.prepend(current)}"
      run(n, path.clone.prepend(current))
    } #.reject(&:nil?).reject(&:empty?)
  end

  def running_up_that_hill
    x = run(@start, [])
    p '---------------------------------------------------------'
    p x.flatten.reject(&:nil?).min
  end
end
