# iteral: true

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
    puts @hash.to_s
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

  #def neighbors(x, y, z, w)
    #@hash[x - 1][y - 1][z - 1][0] + @hash[x - 1][y][z - 1][0] + @hash[x - 1][y + 1][z - 1][0] +
      #@hash[x][y - 1][z - 1][0] + @hash[x][y][z - 1][0] + @hash[x][y + 1][z - 1][0] +
      #@hash[x + 1][y - 1][z - 1][0] + @hash[x + 1][y][z - 1][0] + @hash[x + 1][y + 1][z - 1][0] +

      #@hash[x - 1][y - 1][z][0] + @hash[x - 1][y][z][0] + @hash[x - 1][y + 1][z][0] +
      #@hash[x][y - 1][z][0] +                      @hash[x][y + 1][z][0] +
      #@hash[x + 1][y - 1][z][0] + @hash[x + 1][y][z][0] + @hash[x + 1][y + 1][z][0] +

      #@hash[x - 1][y - 1][z + 1][0] + @hash[x - 1][y][z + 1][0] + @hash[x - 1][y + 1][ z + 1][0] +
      #@hash[x][y - 1][z + 1][0] + @hash[x][y][z + 1][0] + @hash[x][y + 1][z + 1][0] +
      #@hash[x + 1][y - 1][z + 1][0] + @hash[x + 1][y][z + 1][0] + @hash[x + 1][y + 1][ z + 1][0]
  #end

  def neighbors(x, y, z, w)
    neigh = (-1..1).map{|dx|
      (-1..1).map{|dy|
        (-1..1).map{|dz|
          (-1..1).map{|dw|
            if dx.zero? && dy.zero? && dz.zero? && dw.zero?
              0
            else
              @hash[x+dx][y+dy][z+dz][w+dw]
            end
          }.sum
        }.sum
      }.sum
    }.sum

    #puts "neigh #{neigh}"
    neigh
  end

  def run(cycles)
    (1..cycles).each{|c| run_one(c)}
    count
  end

  def run_one(cycle)
    min = 0 - cycle
    max = @size + cycle
    zmin = -cycle
    zmax = +cycle
    #wmin = 0
    #wmax = 0
    wmin = -cycle
    wmax = +cycle


    puts "run_one"

    @next_hash = new_hash

    (min..max).each{|x|
      (min..max).each{|y|
        (zmin..zmax).each{|z|
          (wmin..wmax).each{|w|
            case @hash[x][y][z][w]
            when 1
              @next_hash[x][y][z][w] = [2, 3].include?(neighbors(x, y, z, w)) ? 1 : 0
            when 0
              @next_hash[x][y][z][w] = [3].include?(neighbors(x, y, z, w)) ? 1 : 0
            else
              puts "what?"
            end
          }
        }
      }
    }

    #(zmin..zmax).each{|z|
      #puts "z #{z}"
      #(min..max).each{|y|
        #puts (min..max).map{|x| @next_hash[x][y][z][0] == 1 ? '#' : '.'}.join
      #}
    #}

    @hash = @next_hash
  end

end
