# frozen_string_literal: true

# Expense report
class Depths
  def initialize(list)
    @list = list
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip).map(&:to_i))
  end

  def run
    increases = 0
    prev = @list.first
    @list[1..].map{|current|
      increases = current > prev ? 1 : 0
      prev = current
      increases
    }.sum
  end

  def sliding
    @list = (0..(@list.length - 3)).map{|i|
      @list[i] + @list[i + 1] + @list[i + 2]
    }
    run
  end
end
