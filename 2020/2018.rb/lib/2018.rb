# frozen_string_literal: true

# EquationFile
class EquationFile
  def initialize(list)
    @list = list
    @part = 1
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def with_priority(part)
    @part = part
    self
  end

  def solve
    @list.map{|eq| Equation.with_priority(@part).parse(eq).solve}.sum
  end
end

# Equation
class Equation
  def initialize
    @list = []
  end

  def parse(str_or_list)
    @list = str_or_list.is_a?(Array) ? str_or_list : str_or_list.gsub('(', '( ').gsub(')', ' )').split(' ')
    self
  end

  def self.with_priority(part)
    case part
    when 1
      EquationWithNoPriority.new
    when 2
      EquationWithPriorityPlus.new
    end
  end

  # solve will solve the parens only and use the subclasses
  # to solve the rest according to the priority
  def solve
    no_parens = []
    until @list.empty?
      token = @list.first
      @list = @list.drop(1)

      case token
      when '('
        no_parens += [solve]
      when ')'
        return Equation.with_priority(@part).parse(no_parens).solve_no_parens
      else
        no_parens += [token]
      end
    end
    @list = no_parens

    solve_no_parens
  end

  def next_token
    @list.slice!(0)
  end
end

# An Equation where + and * have equal priority
class EquationWithNoPriority < Equation
  def initialize
    @part = 1
    super
  end

  def solve_no_parens
    total = next_token.to_i

    until @list.empty?
      case next_token
      when '+'
        total += next_token.to_i
      when '*'
        total *= next_token.to_i
      end
    end
    total
  end
end

# An Equation where + has priority
class EquationWithPriorityPlus < Equation
  def initialize
    @part = 2
    super
  end

  def solve_no_parens
    while @list.include?('+')
      plus = @list.find_index('+')
      @list[plus - 1, 3] = @list[plus - 1].to_i + @list[plus + 1].to_i
    end

    @list.reject{|e| e == '*'}.map(&:to_i).reduce(&:*)
  end
end
