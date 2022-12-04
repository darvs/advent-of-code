# frozen_string_literal: true

# Camp Cleanup
class Cleanup
  def initialize(list)
    @list = list.map{|l| parse(l)}
  end

  def parse(line)
    a, b = line.split(',')
    [a.split('-'), b.split('-')].flatten.map(&:to_i)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def fully_contained
    #p @list
    @list.filter{|a, b, c, d|
      ((a <= c && b >= d) || (c <= a && d >= b))
    }.count
  end

  def overlapping
    #p @list
    @list.filter{|a, b, c, d|
      a.between?(c, d) || b.between?(c, d) || c.between?(a, b) || d.between?(a, b)
    }.count
  end
end
