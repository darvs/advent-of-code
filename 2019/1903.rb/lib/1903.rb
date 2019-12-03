# frozen_string_literal: true


# A wire definition class
class WireChecker

  D=1
  X0=2
  Y0=3
  X1=4
  Y1=5

  def initialize(filename)
    @x = File.open(File.join('data', filename)).map.with_index{|line, number| [number, line.strip.split(',')]}
    @list = @x.map{|line| parse(line)}
  end

  def process
    @list[0].product(@list[1])
            .select{|z| z[0][D] != z[1][D]}
            .map{|x| cross(x[0], x[1])}
            .compact
            .map{|y| y[0].abs + y[1].abs}
            .select{|z| z != 0}
            .sort[0]
  end

  def parse(line)
    linenum = line[0]
    parse_moves(linenum, 0, 0, [], line[1])
  end

  def orientation(direction)
    case direction when 'U', 'D' then 'V' else 'H' end
  end

  def parse_moves(line, x0, y0, list, moves)
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

    case direction
    when 'U', 'R' then ordered = [line, orientation(direction), x0, y0, x, y]
    else ordered = [line, orientation(direction), x, y, x0, y0]
    end

    parse_moves(line, x, y, list << ordered, moves[1..-1])
  end

  def vertical(line)
    line[X0] == line[X1]
  end

  def horizontal(line)
    not vertical(line)
  end

  def vxh(lhs, rhs)
    #puts "lhs #{lhs} rhs #{rhs}"
    if vertical(lhs) && horizontal(rhs) && lhs[X0] >= rhs[X0] && lhs[X0] <= rhs[X1] && rhs[Y0] >= lhs[Y0] && rhs[Y0] <= lhs[Y1]
      #puts "yes [#{lhs[X0]}, #{rhs[Y0]}]"
 
      return [lhs[X0], rhs[Y0]]
    end
    #puts "nope"
  end

  def cross(lhs, rhs)
    v = vxh(lhs, rhs)
    return v if !v.nil?

    vxh(rhs, lhs)
  end
end
