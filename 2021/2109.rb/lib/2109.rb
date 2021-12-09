# frozen_string_literal: true

# ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn
class Smoke
  def initialize(input)
    @list = input
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip))
  end

  def run
    winnars = []

    @list.each_with_index{|line, y|
      line.chars.each_with_index{|char, x|
        num = char.to_i

        #p "x,y #{x},#{y} : #{num}"

        cond = ((y.zero? || compare(num, y - 1, x)) &&
        (y == (@list.length - 1) || compare(num, y + 1, x)) &&
        (x.zero? || compare(num, y, x - 1)) &&
        (x == (@list[y].length - 1) || compare(num, y, x + 1)))

        winnars += [num] if cond
      }
    }
    winnars.map{|x| x + 1}.sum
  end

  def compare(num, y, x)
    num2 = @list[y][x].to_i
    #p ["compare #{num} < #{num2}"]
    num < num2
  end
end
