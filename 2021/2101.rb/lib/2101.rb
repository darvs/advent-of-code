# frozen_string_literal: true

# Depths
class Depths
  def initialize(list)
    @list = list
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip).map(&:to_i))
  end

  def run
    @list = (0..(@list.length - 2)).map{|i|
      x, y = @list[i, 2]
      y > x ? 1 : 0
    }.sum
  end

  def sliding
    @list = (0..(@list.length - 3)).map{|i|
      @list[i, 3].sum
    }
    run
  end
end
