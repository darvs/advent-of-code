# frozen_string_literal: true

# A Singer
class KateBush
  HIGH = 'SabcdefghijklmnopqrstuvwxyzE'

  def initialize(list)
    @top = HIGH.index('E')
    @start = []
    @end = []
    @current = []

    @map = parse(list)

    @map_w = @map[0].length
    @map_h = @map.length
  end

  def parse(list)
    list.each_with_index.map{|line, y|
      line.chars.each_with_index.map{|hi, x|
        #p "[#{x},#{y}] hi #{hi} li #{line}"
        if hi == 'S'
          @start = [x, y]
          @current = @start
        end

        @end = [x, y] if hi == 'E'
        HIGH.index(hi)
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
    return nil unless @map[y][x] <= h + 1

    return nil if path_set.include?([x, y])

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
    x, y = current
    h = @map[y][x]

    #return path.prepend(current) if h == @top
    return path.prepend(current).length - 1 if h == @top # -1 removes the origin

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
