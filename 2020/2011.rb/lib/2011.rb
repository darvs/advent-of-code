# frozen_string_literal: true

# Seats
class Seats
  def initialize(list)
    @list = list
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def run_til_stable
    state = @list.join
    newstate = ""

    while newstate != state
      state = newstate
      newstate = run.join
    end

    puts "last #{state}"

    state.chars.select{|x| x=='#'}.count
  end

  def run
    newList = @list.map.with_index{|line, y|
      line.chars.map.with_index{|chair, x|
        occ = occupied_next(y, x)
        if chair == 'L' && occ == 0
          '#'
        elsif chair == '#' && occ >= 4
          'L'
        else
          chair
        end
      }.join
    }
    @list = newList
    #puts "--------------------------"
    #puts @list
    @list
  end

  def occupied?(y, x)
    y.between?(0, @list.length - 1) &&
      x.between?(0, @list[0].length - 1) &&
      @list[y][x] == '#' ? 1 : 0
  end

  def occupied_next(y, x)
    n = occupied?(y-1, x-1)
    n += occupied?(y-1, x)
    n += occupied?(y-1, x+1)
    n += occupied?(y, x-1)
    n += occupied?(y, x+1)
    n += occupied?(y+1, x-1)
    n += occupied?(y+1, x)
    n += occupied?(y+1, x+1)
    #puts "#{y},#{x} #{n}"
    n
  end
end
