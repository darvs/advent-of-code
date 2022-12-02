# frozen_string_literal: true

# Calories
class Calories
  def initialize(all)
    @list = zero_split(all)
  end

  def zero_split(list, split = [])
    #puts "list #{list}"

    zero = list.index(&:zero?)

    return split.append(list) if zero.nil?

    zero_split(list[zero + 1..], split.append(list[0, zero]))
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip).map(&:to_i))
  end

  def most_calories
    #puts "l #{@list}"
    @list.map(&:sum).max
  end

  def total_three_most_calories
    #puts "l #{@list}"
    @list.map(&:sum).sort.reverse.take(3).sum
  end
end
