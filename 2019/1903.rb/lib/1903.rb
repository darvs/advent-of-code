# frozen_string_literal: true

require 'ruby-prolog'

# A wire definition class
class WireChecker

  def gt(a, b)
    a > b
  end

  def initialize(filename)
    @prolog = RubyProlog::Core.new
    @x = File.open(File.join('data', filename)).map.with_index{|line, number| [number, line.strip.split(',')]}
    #p @x
    @x.each{|line| parse(line)}

    @prolog.instance_eval do
      p query(lines[:L, :X0, :Y0, :X, :Y])

      cross[:AX0, :AY0] << [
        lines[:A, :AX0, :AY0, :AX1, :AY1],
        lines[:B, :BX0, :BY0, :BX1, :BY1],
        noteq[:A, :B],
        eq[:AX0, :AX1]
      ]

      p query(cross[:X, :Y])
    end
  end

  def parse(line)
    linenum = line[0]
    #puts "line ##{linenum}"
    parse_moves(linenum, 0, 0, [], line[1])
  end

  def parse_moves(line, x0, y0, list, moves)
    return list if moves.empty?

    move = moves.first

    direction = move[0]
    len = move[1..-1].to_i

    x = x0
    y = y0

    case direction
    when 'U'
      y += len
    when 'D'
      y -= len
    when 'R'
      x += len
    when 'L'
      x += len
    end

    @prolog.instance_eval do
      lines[line, x0, y0, x, y].fact
    end

    parse_moves(line, x, y, list << move, moves[1..-1])
  end
end
