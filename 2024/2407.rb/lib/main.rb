# frozen_string_literal: true

# Program
class Program
  def initialize(list)
    @equation = []
    @concatenation = false

    list.each{|line|
      total, rest = *line.split(':')
      @equation += [[total.to_i, rest.split(' ').map(&:to_i)]]
    }
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def use_concatenation
    @concatenation = true
  end

  def run
    @equation.select{|eq|
      compute(eq)
    }.map{|e| e[0]}.sum
  end

  def compute(eq)
    total, list = eq
    return false if total.negative?
    return total == list[0] if list.length == 1

    candidates = []

    *new_list, last = list

    total_s = total.to_s
    last_s = last.to_s

    # * operator
    candidates += [[total / last, new_list]] if (total % last).zero?

    # | operator
    candidates += [[total_s[0..-last_s.length - 1].to_i, new_list]] if @concatenation && total_s.end_with?(last_s)

    # + operator
    candidates += [[total - last, new_list]]

    candidates.any?{|c| compute(c)}
  end
end
