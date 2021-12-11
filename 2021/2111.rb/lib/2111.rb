# frozen_string_literal: true

# ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn
class Octopi
  def initialize(input)
    p @list = input
    @glowies = 0
    @all_sync = nil
    @turn = 0
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map{|line| line.strip.chars.map(&:to_i)})
  end

  def step(n, until_all_sync = false)
    return if !until_all_sync && n.zero?

    p "step #{n}"
    (0..(@list.length - 1)).each_with_object([]){|y, flashers|
      flashers <<
        (0..(@list[0].length - 1)).each_with_object([]){|x, nextploders|
          @list[y][x] += 1
          nextploders << [y, x] if @list[y][x] == 10
        }
    }.flatten(1).each{|x| contaminate(x)}

    p "Check: #{@list}"

    @list.each_with_index{|line, line_num|
      line.each_with_index{|v, col_num|
        if v > 9
          @glowies += 1
          @list[line_num][col_num] = 0
        end
      }
    }
    p "Modded: #{@list}"

    if @all_sync.nil?
      @turn += 1
      @all_sync = @turn if @list.flatten.all?(&:zero?)
    end

    step(n - 1, until_all_sync) unless until_all_sync && @all_sync
  end

  def glowies
    #@list.map{|line| line.map(&:to_s).reduce(&:+)}.each{|x| p x}
    @glowies
  end

  def all_sync_at
    @all_sync
  end

  def contaminate(point)
    p "contaminate #{point}"
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
    }.filter{|y, x| y.between?(0, lines - 1) && x.between?(0, columns - 1)}

  end


  def check1(y, x)
    ((y.zero? || compare(y, x, y - 1, x)) &&
    (y == (@list.length - 1) || compare(y, x, y + 1, x)) &&
    (x.zero? || compare(y, x, y, x - 1)) &&
    (x == (@list[y].length - 1) || compare(y, x, y, x + 1)))
  end

  def compare(y, x, y2, x2)
    #p "compare #{y},#{x},#{y2},#{x2} | #{@list}"

    num = @list[y][x].to_i
    num2 = @list[y2][x2].to_i
    #p ["compare #{num} < #{num2}"]
    num < num2
  end

  def directions(y, x)
    [[y - 1, x], [y, x + 1], [y + 1, x], [y, x - 1]]
  end

  def valid_point(y, x)
    !y.negative? && (y < @list.length) && !x.negative? && (x < @list[0].length)
  end

  def part2
    low_points.map{|y, x|
      @basin = [[y, x]]
      grow(y, x)

      #p "!basin sz=#{@basin.length} #{@basin}"
      @basin.length
    }.sort.reverse.take(3).reduce(&:*)
  end

  def grow(y, x)
    directions(y, x).filter{|y2, x2| valid_point(y2, x2)}.each{|y2, x2|
      next if @basin.include?([y2, x2])
      next if @list[y2][x2].to_i == 9
      next unless compare(y, x, y2, x2)

      @basin += [[y2, x2]]
      grow(y2, x2)
    }
  end
end
