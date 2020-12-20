# frozen_string_literal: true

# Jurassic Puzzle
class Puzzle
  def initialize(lines)
    @tiles = {}
    @edges = {}
    parse(lines)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def parse(lines)
    puts lines.to_s
    until lines.empty? || lines.first.empty?
      m = /\ATile (?<tile>\d+):\Z/.match(lines.first)
      tile = m[:tile]
      lines.slice!(0)

      picture = []

      until lines.first.empty?
        picture += [lines.first]
        lines.slice!(0)
      end

      lines.slice!(0)

      @tiles[tile] = picture
    end

    puts @tiles

    @tiles.each{|id, data|
      top = encode(data[0].chars)
      right = encode(data.map{|line| line[-1]})
      bottom = encode(data[9].chars.reverse)
      left = encode(data.map{|line| line[0]}.reverse)

      @edges[id] = [top, right, bottom, left]
    }

    puts @edges

    @edges.each{|id, lst|
      lst.map{|v| v.to_i(2)}.tap{|encoded| puts "#{id}  #{encoded}"}
      lst.map{|v| v.reverse.to_i(2)}.tap{|encoded| puts "#{id}r #{encoded}"}
    }

  end

  def encode(chars)
    chars.map{|c| c == '#' ? '1' : '0'}.join
      .tap{|encoded| puts "chars #{chars} encoded #{encoded}"}
  end

  def multiply
    0
  end
end
