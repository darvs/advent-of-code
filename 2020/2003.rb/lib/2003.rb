# frozen_string_literal: true

# Toboggan
class Toboggan
  def initialize(list)
    @list = list
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def run(part)
    case part
    when 1
      slopes = [[3, 1]]
    when 2
      slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
    end

    mul = 1

    slopes.map{|sl|
      trees = 0
      x = 0
      y = 0
      while y < @list.length - 1
        y += sl[1]
        x += sl[0]
        #puts @list[y]
        #puts @list[y][x]
        trees += 1 if @list[y][x % @list[y].length] == '#'
      end
      trees
    }.reduce(&:*)

  end

end
