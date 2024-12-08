# frozen_string_literal: true

# Program
class Program
  def initialize(list)
    @equation = []
    list.each{|line|
      total, rest = *line.split(':')
      @equation += [[total.to_i, rest.split(' ').map(&:to_i)]]
    }
    p "equation #{@equation}"
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def run
    @equation.select{|eq|
      #p "eq #{eq}"
      total, list = *eq
      compute(total, list)
    }.map{|e| e[0]}.sum
  end

  def compute(total, list)
    #p "compute #{total}, #{list}"
    return false if total.negative?
    return total == list[0] if list.length == 1

    *new_list, last = list

    # shortcut if not divisible by last
    return compute(total - last, new_list) unless (total % last).zero?

    compute(total - last, new_list) || compute(total / last, new_list)
  end
end
