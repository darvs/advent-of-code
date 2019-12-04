# frozen_string_literal: true


# A wire definition class
class WireChecker

  def initialize(filename)
    @x = File.open(File.join('data', filename)).map.with_index{|line, number| [number, line.strip.split(',')]}
    @list = @x.map{|line| parse(line)}
  end

  def process
    #p @list
    @list[0].product(@list[1])
            .map{|x| cross(x[0], x[1])}
            .compact
            .map{|y| y[0].abs + y[1].abs}
            .reject(&:zero?)
            .min
  end

  def parse(line)
    linenum = line[0]
    parse_moves(linenum, line[1])
  end

  def orientation(direction)
    case direction when 'U', 'D' then :vertical else :horizontal end
  end

  def parse_moves(line, moves, x0 = 0, y0 = 0, list = [])
    return list if moves.empty?

    move = moves.first

    direction = move[0]
    len = move[1..-1].to_i

    x = x0
    y = y0

    case direction
    when 'U' then y += len
    when 'D' then y -= len
    when 'R' then x += len
    when 'L' then x -= len
    end

    current = { lineno: line, orientation: orientation(direction), x0: x0, y0: y0, x1: x, y1: y }

    parse_moves(line, moves[1..-1], x, y, list << current)
  end

  def between(x, a, b)
    return between(x, b, a) if a > b

    (a..b).include?(x)
  end

  def cross(lhs, rhs)
    return nil if lhs[:orientation] == rhs[:orientation]
    return cross(rhs, lhs) if lhs[:orientation] != :vertical

    if between(lhs[:x0], rhs[:x0], rhs[:x1]) &&
       between(rhs[:y0], lhs[:y0], lhs[:y1])
      [lhs[:x0], rhs[:y0]]
    end
  end
end
