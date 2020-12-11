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

  def run_til_stable(tolerance, infinite)
    state = @list.join
    newstate = ''

    while newstate != state
      state = newstate
      newstate = run(tolerance, infinite).join
    end

    #puts "last #{state}"

    state.chars.select{|x| x == '#'}.count
  end

  def run(tolerance, infinite)
    #puts("run #{tolerance} #{infinite}")
    new_list = @list.map.with_index{|line, y|
      line.chars.map.with_index{|chair, x|
        occ = occupied_next(y, x, infinite)
        if chair == 'L' && occ.zero?
          '#'
        elsif chair == '#' && occ >= tolerance
          'L'
        else
          chair
        end
      }.join
    }
    @list = new_list
    #puts "--------------------------"
    #puts @list
    @list
  end

  def occupied?(y, x, dy, dx, infinite)
    return 0 unless y.between?(0, @list.length - 1)

    return 0 unless x.between?(0, @list[0].length - 1)

    return 1 if @list[y][x] == '#'

    return 0 if @list[y][x] == 'L'

    return 0 unless infinite == true

    occupied?(y + dy, x + dx, dy, dx, infinite)
  end

  def occupied_next(y, x, infinite)
    [[-1, -1], [-1, 0], [-1, 1],
     [0, -1], [0, 1],
     [1, -1], [1, 0], [1, 1]].map{|dy, dx| occupied?(y + dy, x + dx, dy, dx, infinite)}.sum
  end
end
