# frozen_string_literal: true

# Rope Bridge
class Rope
  def initialize(list)
    @list = list.map(&:split).map{|i, n| [i, n.to_i]}

    @h = [0, 0]
    @t = [0, 0]

    @tails = Set.new
    @tails.add(@t)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:chomp))
  end

  def run
    @list.each{|move, n|
      (1..n).each{
        #p move
        x, y = @h

        case move
        when 'U'
          @h = [x, y + 1]
        when 'D'
          @h = [x, y - 1]
        when 'R'
          @h = [x + 1, y]
        when 'L'
          @h = [x - 1, y]
        end

        # new x, y
        hx, hy = @h
        tx, ty = @t
        dx = hx - tx
        dy = hy - ty

        next if dx.abs <= 1 && dy.abs <= 1

        #p 'gotta move'

        tx += 1 if dx.positive?
        tx -= 1 if dx.negative?
        ty += 1 if dy.positive?
        ty -= 1 if dy.negative?

        @t = [tx, ty]
        @tails.add(@t)

      }
    }
  end

  def position_count
    p @list
    run
    p "end h #{@h}"
    p "end t #{@t}"
    p "tails #{@tails}"

    @tails.length
  end
end
