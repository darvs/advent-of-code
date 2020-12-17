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
    Hash.new{ |h, k| h[k] = Hash.new{|h2, k2| h2[k2] = Hash.new(0)}}
  end

  def parse(list)
    #size = list.first.length
    list.each.with_index{|l, y|
      l.each_char.with_index{|c, x|
        @hash[x][y][0] = (c == '#') ? 1 : 0
      }
    }
  end

  def count
    puts @hash.to_s
    @hash.keys.map{|x|
      @hash[x].keys.map{|y|
        @hash[x][y].keys.map{|z|
          @hash[x][y][z]}.sum}.sum}.sum
  end

  def neighbors(x,y,z)
    @hash[x - 1][y - 1][z - 1] + @hash[x - 1][y][z - 1] + @hash[x - 1][y + 1][z - 1] +
      @hash[x][y - 1][z - 1] + @hash[x][y][z - 1] + @hash[x][y + 1][z - 1] +
      @hash[x + 1][y - 1][z - 1] + @hash[x + 1][y][z - 1] + @hash[x + 1][y + 1][z - 1] +

      @hash[x - 1][y - 1][z] + @hash[x - 1][y][z] + @hash[x - 1][y + 1][z] +
      @hash[x][y - 1][z] +                      @hash[x][y + 1][z] +
      @hash[x + 1][y - 1][z] + @hash[x + 1][y][z] + @hash[x + 1][y + 1][z] +

      @hash[x - 1][y - 1][z + 1] + @hash[x - 1][y][z + 1] + @hash[x - 1][y + 1][ z + 1] +
      @hash[x][y - 1][z + 1] + @hash[x][y][z + 1] + @hash[x][y + 1][z + 1] +
      @hash[x + 1][y - 1][z + 1] + @hash[x + 1][y][z + 1] + @hash[x + 1][y + 1][ z + 1]
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

    @next_hash = new_hash

    (min..max).each{|x|
      (min..max).each{|y|
        (zmin..zmax).each{|z|
          case @hash[x][y][z]
          when 1
            @next_hash[x][y][z] = [2, 3].include?(neighbors(x, y, z)) ? 1 : 0
          when 0
            @next_hash[x][y][z] = [3].include?(neighbors(x, y, z)) ? 1 : 0
          end
        }
      }
    }

    (zmin..zmax).each{|z|
      puts "z #{z}"
      (min..max).each{|y|
        puts (min..max).map{|x| @next_hash[x][y][z] == 1 ? '#' : '.'}.join
      }
    }

    @hash = @next_hash
  end

end
