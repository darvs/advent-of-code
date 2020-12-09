# frozen_string_literal: true

# XMAS
class XMAS
  def initialize(list)
    @list = list
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip).map(&:to_i))
  end

  def check(preamble, checking)
    #puts "pre #{preamble} @list.length-1 #{@list.length - 1} list #{@list}"

    (preamble..(@list.length - 1)).each{|n|
      #puts "##{n} #{@list[n]}"
      res = @list[n - checking, n - 1].combination(2)
                                      .select{|a, b| a + b == @list[n]}
      return @list[n] if res.empty?
    }
    0
  end

  def part2(total)
    r = find_range(total)
    #puts "min #{r.min} max #{r.max} r #{r}"
    r.min + r.max
  end

  def find_range(total)
    #puts "Looking for range for #{total}"
    (0..(@list.length - 2)).each{|start|
      sum = @list[start]
      num = start + 1
      while num < @list.length
        break if sum > total

        #puts "sum : #{sum}"
        sum += @list[num] if sum < total
        if sum == total
          #puts ["range #{total} sum #{sum} start #{start} num-1 #{num - 1}"]
          return @list[start, num - start + 1] if sum == total
        end
        num += 1
      end
    }
    0
  end
end
