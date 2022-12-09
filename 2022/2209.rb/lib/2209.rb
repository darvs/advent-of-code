# frozen_string_literal: true

# Rope Bridge
class Rope
  def initialize(list, number_of_knots)
    @list = list.map(&:split).map{|i, n| [i, n.to_i]}

    #@h = [0, 0]
    #@t = [0, 0]

    @knots = Array.new(number_of_knots, [0, 0])
    #p "knots #{@knots}"

    @tails = Set.new
    @tails.add([0, 0])
  end

  def self.from_file(filename, number_of_knots)
    new(File.readlines(File.join('data', filename)).map(&:chomp), number_of_knots)
  end

  def run
    @list.each{|move, n|
      (1..n).each{
        # ------------------------------------
        #  First we move the head
        # ------------------------------------

        #p move
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

        # ------------------------------------
        #  Then all the other knots
        # ------------------------------------

        (1..@knots.length - 1).each{|i|
          # new x, y
          x1, y1 = @knots[i - 1]
          x2, y2 = @knots[i]
          dx = x1 - x2
          dy = y1 - y2

          next if dx.abs <= 1 && dy.abs <= 1

          #p 'gotta move'

          x2 += 1 if dx.positive?
          x2 -= 1 if dx.negative?
          y2 += 1 if dy.positive?
          y2 -= 1 if dy.negative?

          @knots[i] = [x2, y2]
        }

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
