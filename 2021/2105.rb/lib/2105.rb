# frozen_string_literal: true

# Hydrothermal Venture
class HydrothermalVenture
  def initialize(input)
    p input.map{|line| parse(line)}
    input.map{|line| parse(line)}.each{|a, b| p "a:#{a} b#{b}"}
    p "---"

    p @list = input.map{|line| parse(line)}

  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip))
  end

  def parse(s)
    data=/(\d+),(\d+) -> (\d+),(\d+)/.match(s)
    [[data[1].to_i, data[2].to_i], [data[3].to_i, data[4].to_i]]
  end

  #def all_points_for_line(a, b)
    #ax, ay = a
    #bx, by = b

    #ay == by ? horizontal_line_points(a, b) : vertical_line_points(a, b)
  #end

  def all_points_for_line(a, b)
    ax, ay = a
    bx, by = b

    extent = [(bx - ax).abs, (by - ay).abs].max

    dx = bx <=> ax
    dy = by <=> ay

    ptt = (0..extent).each_with_object([]){|n, points|
      #p "w"
      x = ax + n * dx
      y = ay + n * dy
      #p ["x is #{n} and y is #{y}"]
      points << ["#{x},#{y}"]
    }

    p ptt
  end





  def horizontal_line_points(a, b)
    ax, y = a
    bx, = b

    return horizontal_line_points(b, a) if ax > bx

    points = []

    (ax..bx).each{|x| points += ["#{x},#{y}"]}

    points
  end

  def vertical_line_points(a, b)
    x, ay = a
    _, by = b

    return vertical_line_points(b, a) if ay > by

    points = []

    (ay..by).each{|y| points += ["#{x},#{y}"]}

    points
  end

  def ignore_diagonals
    @list = @list.reject{|a, b|
      (a[0] != b[0]) && (a[1] != b[1])
    }
  end

  def overlap
    all_points = @list.each_with_object([]){|line, points|
      a, b = line
      points << all_points_for_line(a, b)
    }.flatten

    p overlap = all_points.each_with_object(Hash.new(0)){|k, h| h[k] += 1}.select{|_, v| v > 1}
    overlap.count
  end
end
