# frozen_string_literal: true

# Handheld Device
class Handheld
  def initialize(string)
    @string = string
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:chomp).first)
  end

  def first_distinct(len)
    ((len - 1)..@string.length - 1).each{|i|
      sub = @string[i - (len - 1), len]
      return i + 1 if sub.chars.map{|c| sub.count(c)}.all?{|v| v == 1}
    }
  end
end
