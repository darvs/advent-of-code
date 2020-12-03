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
    slopes = [[[3, 1]], [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]][part - 1]

    slopes.map{|x, y|
      (0..@list.length - 1).step(y).select.with_index{|line_num, index|
        line = @list[line_num]
        line[(x * index) % line.length] == '#'
      }.count
    }.reduce(&:*)
  end
end
