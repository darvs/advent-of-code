# frozen_string_literal: true

# A wire definition class
class WireChecker
  def initialize(filename)
    list = File.open(File.join('data', filename))
               .map(&:strip)
               .map{|l| l.split(',')}
               .map{|line| parse(line)}

    @crossings = list[0].product(list[1])
                        .map{|x| cross(x[0], x[1])}
                        .compact
  end

  def intersection
    @crossings.map{|crossing| crossing[:x].abs + crossing[:y].abs}
              .reject(&:zero?)
              .min
  end

  def wire_length
    @crossings.map{|crossing| crossing[:wire_length]}
              .reject(&:zero?)
              .min
  end

  def orientation(direction)
    case direction when 'U', 'D' then :vertical else :horizontal end
  end

  def manhattan_distance(x0, y0, x1, y1)
    (x1 - x0).abs + (y1 - y0).abs
  end

  def parse(moves, x0 = 0, y0 = 0, wire_length = 0, list = [])
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

    current = { orientation: orientation(direction),
                wire_length: wire_length,
                x0: x0, y0: y0, x1: x, y1: y }

    parse(moves[1..-1],
          x, y,
          wire_length + manhattan_distance(x0, y0, x, y),
          list << current)
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

      cross_at = { x: lhs[:x0], y: rhs[:y0] }

      { x: cross_at[:x], y: cross_at[:y],
        wire_length: lhs[:wire_length] +
          manhattan_distance(lhs[:x0], lhs[:y0], cross_at[:x], cross_at[:y]) +
          rhs[:wire_length] +
          manhattan_distance(rhs[:x0], rhs[:y0], cross_at[:x], cross_at[:y]) }
    end
  end
end
