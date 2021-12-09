# frozen_string_literal: true

# ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn
class Smoke
  def initialize(input)
    @list = input
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip))
  end

  def part1
    low_points.map{|y, x| @list[y][x].to_i + 1}.sum
  end

  def low_points
    winnars = []

    @list.each_with_index{|line, y|
      (0..line.length - 1).each{|x|
        winnars += [[y, x]] if check1(y, x)
      }
    }
    winnars
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
