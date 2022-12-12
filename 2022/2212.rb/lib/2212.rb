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
    @current = []

    @map = Hash.new{nil}
    parse(list)

    @map_w = list[0].length 
    @map_h = list.length
  end

  def parse(list)
    list.each_with_index{|line, y|
      line.chars.each_with_index{|hi, x|
        #p "[#{x},#{y}] hi #{hi} li #{line}"
        if hi == 'S'
          @start = [x, y]
          @current = @start
        end

        @end = [x, y] if hi == 'E'
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

  def valid_direction(x, y, h, path_set)
    return nil unless x.between?(0, @map_w - 1)
    return nil unless y.between?(0, @map_h - 1)
    #p "x #{x}/#{@map_w} y #{y}"
    return nil unless @map[[y, x]].height <= h + 1

    return nil if path_set.include?([x, y])

    return nil unless @map[[y, x]].check_distance(path_set.length)

    [x, y]
  end

  def next_directions(x, y, h, path_set)
    [valid_direction(x + 1, y, h, path_set),
     valid_direction(x - 1, y, h, path_set),
     valid_direction(x, y + 1, h, path_set),
     valid_direction(x, y - 1, h, path_set)].reject(&:nil?)
  end

  def run(current, path)
    #p "run #{current} , #{path}"
    #p "map #{@map}"
    x, y = current
    h = @map[[y, x]].height

    #return path.prepend(current) if h == @top
    if h == @top
      p "Reached the top with path of length #{path.length}"
      return path.length # + 1 for current, -1 removes the origin
    end

    valid_next = next_directions(x, y, h, path.to_set)

    #return nil if valid_next.empty?
    return nil if valid_next.empty?

    #[valid_next]

    
    valid_next.map{|n|
      #p "#{current} -> #{n} : #{path.clone.prepend(current)}"
      run(n, path.clone.prepend(current))
    }#.reject(&:nil?).reject(&:empty?)
  end

  def running_up_that_hill
    x = run(@start, [])
    p "---------------------------------------------------------"
    p x.flatten.reject(&:nil?).min
  end
end
