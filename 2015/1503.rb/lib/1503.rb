# frozen_string_literal: true

# Santa's Itinary
class Itinerary
  def initialize(string)
    @str = string
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip).join)
  end

  def run(nb_santas)
    santas = Array.new(nb_santas, [0, 0])
    @houses = Set[[0, 0]]

    @str.each_char.with_index{|c, i|
      current = i % santas.size
      santas[current] = move_from(santas[current], c)
      @houses += [santas[current]]
    }

    @houses.size
  end

  def move_from(pos, chr)
    x, y = pos

    case chr
    when '^'
      y -= 1
    when 'v'
      y += 1
    when '<'
      x -= 1
    when '>'
      x += 1
    end

    [x, y]
  end
end
