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

  def self.from_key(key)
    new(key.first, key.drop(1).first)
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
    dq, dr = delta(dir)
    @q += dq
    @r += dr
  end

  def delta(dir)
    case dir
    when :e
      dq = 1
      dr = 0
    when :w
      dq = -1
      dr = 0
    when :nw
      dq = @r.even? ? -1 : 0
      dr = -1
    when :ne
      dq = @r.odd? ? 1 : 0
      dr = -1
    when :sw
      dq = @r.even? ? -1 : 0
      dr = 1
    when :se
      dq = @r.odd? ? 1 : 0
      dr = 1
    end
    [dq, dr]
  end

  def neighbors
    %i[nw ne sw se w e].map.with_object(Set.new){|dir, set|
      dq, dr = delta(dir)
      set << ODDR.new(@q + dq, @r + dr)
    }
  end
end

# Tiles
class Tiles
  def initialize(list)
    @black_keys = Set.new
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

  def flip_key(key)
    @black_keys.delete(key) if @black_keys.add?(key).nil?
  end

  def flip(tile)
    flip_key(tile.key)
  end

  def switched
    @list.each{|tile| flip(tile)}
    #puts "tiles #{@tiles}"
    @black_keys.length
  end

  def day(d)
    @list.each{|tile| flip(tile)}

    #puts "start day #{@black_keys.length}"

    until d.zero?
      change_keys = Set.new

      black = @black_keys.map{|key| ODDR.from_key(key)}.to_a

      #puts "black #{black}"

      white = black.each_with_object(Set.new){|tile, set|
        # Collect neighbors to check later
        neighbors = tile.neighbors
        #puts "0 neighbors #{neighbors}"
        set.merge(neighbors)

        # Flip black tiles with zero or more than 2 black neighbors
        black_neighbors = neighbors.select{|t| @black_keys.include?(t.key)}.length
        #puts "0 [#{!black_neighbors.between?(1, 2)}] black neighbors #{black_neighbors}"
        change_keys << tile.key unless black_neighbors.between?(1, 2)
      }.reject{|t| @black_keys.include?(t.key)}

      white.each{|tile|
        neighbors = tile.neighbors
        #puts "1 neighbors #{neighbors}"

        black_neighbors = neighbors.select{|t| @black_keys.include?(t.key)}.length
        #puts "1 [#{black_neighbors == 2}] black neighbors #{black_neighbors}"
        change_keys << tile.key if black_neighbors == 2
      }

      #puts "change_keys #{change_keys}"
      change_keys.each{|key| flip_key(key)}

      d -= 1
    end

    #puts "day #{@black_keys.length}"
    @black_keys.length
  end
end
