# frozen_string_literal: true

# Expense report
class Expense
  def initialize(list : Array(Int32))
    @list = list
  end

  def self.from_file(filename)
    new((File.read_lines(File.join("../2001.rb/data", filename))
      .map &.strip).map &.to_i)
  end

  def run(number)
    case number
    when 2
      part1
    else
      part2
    end
  end

  def part1
    sub(2020, @list)
  end

  def part2
    sublist = Array(Int32).new
    answer = 0
    @list.each{|n|
      answer = sub(2020 - n, sublist)
      if answer != 0
        answer = n * answer
        break
      end
      sublist << n
    }
    answer
  end

  def sub(total, list)
    answer = 0
    set = Set(Int32).new

    list.each{|n|
      if set.includes?(total - n)
        answer = n * (total - n)
        break
      end
      set << n
    }

    answer
  end
end
x = Expense.from_file("2001.in")
puts x.part1 
puts x.part2
