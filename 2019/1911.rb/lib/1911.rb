# frozen_string_literal: true

# A robot that paints the spaceship's hull
class PaintingRobot
  DIRECTIONS = [[0, 1], [1, 0], [0, -1], [-1, 0]].freeze

  def initialize(filename, initial_color)
    @panels = Hash.new(0)

    x = 0
    y = 0
    orientation = 0

    computer = IntcodeInterpreter.from_file(filename)
    @panels[key(0, 0)] = initial_color

    loop do
      computer.add_input(@panels[key(x, y)])
      computer.run
      break if computer.state == :terminated

      @panels[key(x, y)], turn = computer.output.split(',').map(&:to_i)
      turn = -1 if turn.zero?

      orientation = (orientation + turn) % DIRECTIONS.length

      x += DIRECTIONS[orientation][0]
      y += DIRECTIONS[orientation][1]
    end
  end

  def painted
    @panels.length
  end

  def key(x, y)
    [x, y]
  end

  def paint
    val = @panels.map{|k, _| k}.each_with_object(Hash.new(Set.new)){|k, hash|
      hash[:x] += [k[0]]
      hash[:y] += [k[1]]
      #hash
    }
    colors = ' #'
    output = val[:y].max.downto(val[:y].min).reduce([]){|list, y|
      list + [(val[:x].min..val[:x].max).reduce(''){|str, x|
        str + colors[@panels[key(x, y)]]
      }]
    }

    output.each{|line| p line}
  end
end
