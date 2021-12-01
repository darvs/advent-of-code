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
    @list[1..].each{|current|
      increases += 1 if current > prev
      prev = current
    }
    increases
  end

  def sliding
    sliding = []
    (0..(@list.length - 3)).each{|i|
      sliding << @list[i] + @list[i + 1] + @list[i + 2]
    }
    @list = sliding
    run
  end
end
