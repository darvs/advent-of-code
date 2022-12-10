# frozen_string_literal: true

# Rope Bridge
class Rope
  def initialize(list, number_of_knots)
    @list = list.map(&:split).map{|i, n| [i, n.to_i]}

    @knots = Array.new(number_of_knots, [0, 0])

    @tails = Set.new
    @tails.add([0, 0])
  end

  def self.from_file(filename, number_of_knots)
    new(File.readlines(File.join('data', filename)).map(&:chomp), number_of_knots)
  end

  def move_head(move)
    x, y = @knots[0]

    case move
    when 'U'
      y += 1
    when 'D'
      y -= 1
    when 'R'
      x += 1
    when 'L'
      x -= 1
    end

    @knots[0] = [x, y]
  end

  def make_unit(nnn)
    if nnn.positive?
      1
    elsif nnn.negative?
      -1
    else
      0
    end
  end

  def following_knots
    (1..@knots.length - 1).each{|i|
      x1, y1 = @knots[i - 1]
      x2, y2 = @knots[i]
      dx = x1 - x2
      dy = y1 - y2

      next if dx.abs <= 1 && dy.abs <= 1

      x2 += make_unit(dx)
      y2 += make_unit(dy)

      @knots[i] = [x2, y2]
    }
  end

  def run
    @list.each{|move, n|
      #p move
      (1..n).each{
        move_head(move)
        following_knots

        # Note the tail's position
        @tails.add(@knots[@knots.length - 1])
      }
    }
  end

  def debug
    #p @list
    p "end h #{@h}"
    p "end t #{@t}"
    p "tails #{@tails}"
  end

  def position_count
    run
    #debug
    @tails.length
  end
end
