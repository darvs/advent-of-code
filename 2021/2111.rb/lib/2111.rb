# frozen_string_literal: true

# ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn
class Octopi
  attr_reader :glowies, :all_sync

  def initialize(input)
    @list = input
    @glowies = 0
    @all_sync = nil
    @turn = 0
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map{|line| line.strip.chars.map(&:to_i)})
  end

  def step(n, until_all_sync = false)
    return if !until_all_sync && n.zero?

    (0..(@list.length - 1)).each_with_object([]){|y, flashers|
      flashers <<
        (0..(@list[0].length - 1)).each_with_object([]){|x, nextploders|
          @list[y][x] += 1
          nextploders << [y, x] if @list[y][x] == 10
        }
    }.flatten(1).each{|x| contaminate(x)}

    # Count glowies
    @list.each_with_index{|line, line_num|
      line.each_with_index{|v, col_num|
        if v > 9
          @glowies += 1
          @list[line_num][col_num] = 0
        end
      }
    }

    # Are they all glowing?
    if @all_sync.nil?
      @turn += 1
      @all_sync = @turn if @list.flatten.all?(&:zero?)
    end

    step(n - 1, until_all_sync) unless until_all_sync && @all_sync
  end

  #def glowies
    #@glowies
  #end

  #def all_sync
    #@all_sync
  #end

  def contaminate(point)
    neighbors(point).each{|y, x|
      @list[y][x] += 1
      contaminate([y, x]) if @list[y][x] == 10
    }
  end

  def neighbors(point)
    lines = @list.length
    columns = @list[0].length
    y, x = point

    [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].map{|direction|
      dy, dx = direction
      [y + dy, x + dx]
    }.filter{|y2, x2| y2.between?(0, lines - 1) && x2.between?(0, columns - 1)}
  end
end
