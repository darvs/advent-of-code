# frozen_string_literal: true

# Adapters
class Adapters
  def initialize(list)
    @list = list
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip).map(&:to_i))
  end

  def part1
    last = 0
    newlist = @list.sort.map{|current|
      #puts "last #{last} current #{current}"
      n = current - last
      last = current
      n
    }.select{|x| [3, 1].include?(x)}

    #puts "newlist #{newlist}"

    h = newlist.each_with_object(Hash.new(0)){|n, count| count[n] += 1}

    # your device's built-in adapter is always 3 higher than the highest adapter
    h[1] * (h[3] + 1)
  end

  def part2
    device = @list.max + 3
    newlist = @list.sort + [device]
    #puts "newlist #{newlist}"

    @memo = Hash.new(-1)
    br = branch(0, newlist)
    #puts "branch #{br}"
    #puts "memo #{@memo}"

    br
  end

  def branch(start, newlist)
    return 1 if start == newlist.max

    return @memo[start] if @memo[start] >= 0

    res = [1, 2, 3].map{|n|
      newlist.include?(start + n) ? branch(start + n, newlist) : 0
    }.sum

    @memo[start] = res
    res
  end
end
