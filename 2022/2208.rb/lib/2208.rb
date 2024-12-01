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
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:chomp))
  end

  def visible?(y, x)
    return true if [0, @len - 1].include?(y)
    return true if [0, @len - 1].include?(x)

    val = @forest[y][x]

    return true if (0..y - 1).map{|yy| @forest[yy][x]}.all?{|other| val > other}
    return true if (0..x - 1).map{|xx| @forest[y][xx]}.all?{|other| val > other}
    return true if (x + 1..@len - 1).map{|xx| @forest[y][xx]}.all?{|other| val > other}
    return true if (y + 1..@len - 1).map{|yy| @forest[yy][x]}.all?{|other| val > other}

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

  def scenic_score(y, x)
    # The scenic score is a multiplication of viewing distances.
    # The trees on the edge always have at least one viewing
    # distance equal to zero.
    # That means any tree on the edge will have a scenic score
    # of 0.

    return 0 if [0, @len - 1].include?(y)
    return 0 if [0, @len - 1].include?(x)

    val = @forest[y][x]

    [(0..y - 1).reverse_each.map{|yy| @forest[yy][x]},
     (0..x - 1).reverse_each.map{|xx| @forest[y][xx]},
     (x + 1..@len - 1).map{|xx| @forest[y][xx]},
     (y + 1..@len - 1).map{|yy| @forest[yy][x]}]
      .map{|l|
        [l.take_while{|vv| val > vv}.count + 1, l.length].min
      }.reduce(&:*)
  end

  # Best Scenery
  def best_scenic_score
    (0..@len - 1).map{|y|
      (0..@len - 1).map{|x|
        scenic_score(y, x)
      }
    }.flatten.max
  end
end
