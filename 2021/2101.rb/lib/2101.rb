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
    @list.each_cons(sliding_size).map(&:sum).each_cons(2).filter{|x, y| y > x}.count
  end
end
