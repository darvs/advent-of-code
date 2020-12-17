#frozen_string_literal: true

# Seats
class ConwayCubes
  def initialize(list)
    @hash = new_hash
    @size = list.first.length
    parse(list)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def new_hash
    Hash.new{ |h, k| h[k] = Hash.new{|h2, k2| h2[k2] = Hash.new{|h3, k3| h3[k3] = Hash.new(0)}}}
  end

  def parse(list)
    #size = list.first.length
    list.each.with_index{|l, y|
      l.each_char.with_index{|c, x|
        @hash[x][y][0][0] = (c == '#') ? 1 : 0
      }
    }
  end

  def count
    #puts @hash.to_s
    @hash.keys.map{|x|
      @hash[x].keys.map{|y|
        @hash[x][y].keys.map{|z|
          @hash[x][y][z].keys.map{|w|
            @hash[x][y][z][w]
          }.sum
        }.sum
      }.sum
    }.sum
  end

  def neighbors(x, y, z, w)
    neigh = (-1..1).map{|dx|
      (-1..1).map{|dy|
        (-1..1).map{|dz|
          (-1..1).map{|dw|
            if [dx, dy, dz, dw].all?(&:zero?)
              0
            else
              @hash[x + dx][y + dy][z + dz][w + dw]
            end
          }.sum
        }.sum
      }.sum
    }.sum

    #puts "neigh #{neigh}"
    neigh
  end

  def run(cycles, dim)
    (1..cycles).each{|c| run_one(c, dim)}
    count
  end

  def run_one(cycle, dim)
    xy_min = 0 - cycle
    xy_max = @size - 1 + cycle
    z_min = -cycle
    z_max = +cycle

    case dim
    when 3
      w_min = 0
      w_max = 0
    when 4
      w_min = -cycle
      w_max = +cycle
    end

    @next_hash = new_hash

    (xy_min..xy_max).each{|x|
      (xy_min..xy_max).each{|y|
        (z_min..z_max).each{|z|
          (w_min..w_max).each{|w|
            case @hash[x][y][z][w]
            when 1
              @next_hash[x][y][z][w] = [2, 3].include?(neighbors(x, y, z, w)) ? 1 : 0
            when 0
              @next_hash[x][y][z][w] = [3].include?(neighbors(x, y, z, w)) ? 1 : 0
            end
          }
        }
      }
    }

    @hash = @next_hash
  end
end
