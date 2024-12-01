# frozen_string_literal: true

# Beams
class Beams
  def initialize(lines)
    # Parse lines
    @tiles = Hash.new{|k, v| k[v] = {}}

    parse_lines(lines)

    @max_x = lines[0].length - 1
    @max_y = lines.count - 1

    @directions = ['>', '<', '^', 'v']

    @current_direction = @directions.first

    @navigation = {}
    initialize_navigation
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def parse_lines(lines)
    lines.each_with_index{|l, y|
      l.chars.each_with_index{|c, x|
        @tiles[x][y] = c
      }
    }
  end

  def add_navigation(direction, symbol, new_direction)
    # Using Array(x) allows us to convert to an array
    # _only_ if x is not already an array
    @navigation[[direction, symbol]] = Array(new_direction)
  end

  def initialize_navigation
    add_navigation('v', '/', '<')
    add_navigation('<', '/', 'v')
    add_navigation('^', '/', '>')
    add_navigation('>', '/', '^')

    add_navigation('v', '\\', '>')
    add_navigation('<', '\\', '^')
    add_navigation('^', '\\', '<')
    add_navigation('>', '\\', 'v')

    add_navigation('v', '-', ['<', '>'])
    add_navigation('^', '-', ['<', '>'])

    add_navigation('<', '|', ['^', 'v'])
    add_navigation('>', '|', ['^', 'v'])
  end

  def energized
    puts "tiles #{@tiles}"
    0
  end
end
