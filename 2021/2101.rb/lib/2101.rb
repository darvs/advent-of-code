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

  def run_with_sliding_size(sliding_size)
    chunks = (0..(@list.length - sliding_size)).map{|i| @list[i, sliding_size].sum}
    (0..(chunks.length - 2)).map{|i| chunks[i, 2]}.filter{|x, y| y > x}.count
  end
end
