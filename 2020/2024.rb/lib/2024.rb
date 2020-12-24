# frozen_string_literal: true

# We'll use an odd-r coordinates system as described on
# https://www.redblobgames.com/grids/hexagons/#coordinates

# An oddr coordinate
class ODDR
  attr_reader :q, :r
  def initialize(q, r)
    @q = q
    @r = r
  end

  def to_s
    "<#{@q},#{@r}>"
  end

  def inspect
    #"ODDR:#{q},#{r}"
    to_s
  end

  # Comparable
  def <=>(other)
    qcomp = @q <=> other_q
    qcomp.zero? ? @r <=> other.r : qcomp
  end

  def key
    [@q, @r]
  end

  def move(dir)
    case dir
    when :e
      @q += 1
    when :w
      @q -= 1
    when :nw
      @q -= 1 if r.even?
      @r -= 1
    when :ne
      @q += 1 if r.odd?
      @r -= 1
    when :sw
      @q -= 1 if r.even?
      @r += 1
    when :se
      @q += 1 if r.odd?
      @r += 1
    end
  end
end

# Tiles
class Tiles
  def initialize(list)
    @tiles = {}
    @list = parse(list)
    #puts @list.to_s
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def read(line, list, dir)
    if line.start_with?(dir)
      line.delete_prefix!(dir)
      list << dir.to_sym
      true
    end
    false
  end

  def parse(list)
    list.map{|line|
      l = []
      until line.empty?
        read(line, l, 'nw') ||
          read(line, l, 'ne') ||
          read(line, l, 'sw') ||
          read(line, l, 'se') ||
          read(line, l, 'w') ||
          read(line, l, 'e')
      end

      l.each_with_object(ODDR.new(0, 0)){|dir, tile| tile.move(dir)}
      #.tap{|tile| puts "t #{tile}"}
    }
  end

  def switched
    @list.each_with_object(Hash.new(0)){|tile, hash| hash[tile.key] += 1}
         #.tap{|rez| puts "rez #{rez}"}
         .select{|_, v| v.odd?}
         .length
  end
end
