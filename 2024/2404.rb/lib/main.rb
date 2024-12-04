# frozen_string_literal: true

# Program
class Program
  def initialize(list)
    @coords = {}
    @letters = Hash.new([])
    map_coordinates(list)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def map_coordinates(list)
    list.each.with_index{|line, y|
      line.each_char.with_index{|letter, x|
        @coords[[x, y]] = letter
        @letters[letter] += [[x, y]]
      }
    }

    #p "coords: #{@coords}"
    #p "letters: #{@letters}"
  end

  def run
    @letters['X'].map{|pair|
      xx, xy = *pair

      look_for_m(xx, xy).select{|mx, my|
        dx = mx - xx
        dy = my - xy
        ax = xx + 2 * dx
        ay = xy + 2 * dy
        sx = xx + 3 * dx
        sy = xy + 3 * dy
        @coords[[ax, ay]] == 'A' && @coords[[sx, sy]] == 'S'
      }.count
    }.sum
  end

  def look_for_m(xx, xy)
    @letters['M'].select{|pair|
      mx, my = *pair
      dx = mx - xx
      dy = my - xy

      dx.abs <= 1 && dy.abs <= 1 ? [mx, my] : nil
    }.reject(&:nil?)
  end
end
