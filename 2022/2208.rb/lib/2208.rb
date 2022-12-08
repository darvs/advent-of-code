# frozen_string_literal: true

# Treetop Tree House
class Treehouse
  def initialize(list)
    @len = list.length

    @forest = Array.new(@len) {Array.new(@len, 0)}

    parse(list)
  end

  def parse(list)
    (0..@len - 1).each{|i|
      list[i].each_char.with_index{|c, j|
        @forest[i][j] = c.to_i
      }
    }
    p @forest
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:chomp))
  end

  #def visible?(y, x)
    #return true if [0, @len - 1].include?(y)
    #return true if [0, @len - 1].include?(x)

    #val = @forest[y][x]

    #return true if
      #val > @forest[y - 1][x] ||
      #val > @forest[y + 1][x] ||
      #val > @forest[y][x - 1] ||
      #val > @forest[y][x + 1]
  #end

  def visible?(y, x)
    return true if [0, @len - 1].include?(y)
    return true if [0, @len - 1].include?(x)

    val = @forest[y][x]

    return true if (0..y - 1).map{|yy| @forest[yy][x]}.all?{|other| val > other}
    return true if (y + 1..@len - 1).map{|yy| @forest[yy][x]}.all?{|other| val > other}

    return true if (0..x - 1).map{|xx| @forest[y][xx]}.all?{|other| val > other}
    return true if (x + 1..@len - 1).map{|xx| @forest[y][xx]}.all?{|other| val > other}

    false
  end

  # How many are visible?
  def visible_count
    (0..@len - 1).map{|y|
      (0..@len - 1).map{|x|
        visible?(y, x)
      }
    }.flatten.filter{|x| x}.count
  end
end
