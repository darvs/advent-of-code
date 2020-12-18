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

  # solve will solve the parens only and use the subclasses'
  # reduce methods to solve the rest according to the priority
  def solve
    while (rparen = @list.find_index(')'))
      lparen = rparen - @list[0..rparen - 1].reverse.find_index('(') - 1
      sub = @list[lparen + 1..rparen - 1]
      @list[lparen..rparen] = Equation.with_priority(@part).parse(sub).solve
    end

    reduce
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

  def reduce
    while @list.length > 1
      @list[0, 3] = case @list[1]
                    when '+'
                      @list[0].to_i + @list[2].to_i
                    when '*'
                      @list[0].to_i * @list[2].to_i
                    end
    end
    @list.first
  end
end

# An Equation where + has priority
class EquationWithPriorityPlus < Equation
  def initialize
    @part = 2
    super
  end

  def reduce
    while (plus = @list.find_index('+'))
      @list[plus - 1, 3] = @list[plus - 1].to_i + @list[plus + 1].to_i
    end

    while (times = @list.find_index('*'))
      @list[times - 1, 3] = @list[times - 1].to_i * @list[times + 1].to_i
    end

    @list.first
  end
end
