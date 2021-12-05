# frozen_string_literal: true

# Hydrothermal Venture
class HydrothermalVenture
  def initialize(input)
    @list = input.map{|line| parse(line)}
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip))
  end

  def parse(line)
    ax, ay, bx, by = /(\d+),(\d+) -> (\d+),(\d+)/.match(line)[1..4].map(&:to_i)
    [[ax, ay], [bx, by]]
  end

  def all_points_for_line(a, b)
    ax, ay = a
    bx, by = b

    len = [(bx - ax).abs, (by - ay).abs].max

    dx = bx <=> ax
    dy = by <=> ay

    (0..len).each_with_object([]){|n, points|
      x = ax + (n * dx)
      y = ay + (n * dy)
      points << ["#{x},#{y}"]
    }
  end

  def ignore_diagonals
    @list = @list.reject{|a, b|
      ax, ay = a
      bx, by = b

      (ax != bx) && (ay != by)
    }
  end

  def overlap
    all_points = @list.each_with_object([]){|line, points|
      a, b = line
      points << all_points_for_line(a, b)
    }.flatten

    all_points.each_with_object(Hash.new(0)){|k, h| h[k] += 1}
              .select{|_, v| v > 1}
              .count
  end
end
