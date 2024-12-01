# frozen_string_literal: true

# Locations
class Locations
  def initialize(text)
    @lists = text.map(&:split).transpose.map{|x| x.map(&:to_i)}
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def sum_of_diff
    @lists.map(&:sort).transpose.map{|pair|
      a, b = *pair
      (a - b).abs
    }.sum
  end

  def sum_of_occurences
    nums, rest = *@lists
    hashi = rest.each_with_object(Hash.new(0)) {|item, h|
      h[item] += 1
    }
    nums.map{|n| n * hashi[n]}.sum
    
  end
end
