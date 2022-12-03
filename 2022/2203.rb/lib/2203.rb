# frozen_string_literal: true

# Rucksack
class Rucksack
  def initialize(list)
    @alphabet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    @list = list
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def sum_priorities
    @list.map{|sack|
      half = sack.length / 2
      [sack[..half - 1], sack[half..]]
    }.map{|left, right| (left.chars.to_set & right.chars.to_set).to_a.first}.map{|c| @alphabet.index(c) + 1}.sum
  end

  def sum_priorities3
    repeats = []
    @list.each_slice(3){|a, b, c| repeats.append((a.chars.to_set & b.chars.to_set & c.chars.to_set).to_a.map{|c| @alphabet.index(c) + 1}.first)}

    repeats.sum
  end

end
