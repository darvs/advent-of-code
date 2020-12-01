# frozen_string_literal: true

# Expense report
class Expense
  def initialize(list)
    @list = list
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip).map(&:to_i))
  end

  def run
    sub(2020, @list)
  end

  def sub(total, list)
    answer = 0
    set = Set.new

    list.each{|n|
      if set.include?(total - n)
        answer = n * (total - n)
        break
      end
      set << n
    }

    answer
  end
end
