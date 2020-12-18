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
    #puts "NEW EQUATION #{list}"
    @list = []
  end

  def parse(str)
    str = str.gsub('(', '( ').gsub(')', ' )')
    @list = str.split(' ')
    self
  end

  def self.with_priority(part)
    case part
    when 1
      EquationWithPriority1.new
    when 2
      EquationWithPriority2.new
    end
  end

  def next_term
    case @list.first
    when '('
      n = find_closing_paren
      num = Equation.with_priority(@part).parse(@list.drop(1).take(n - 1).join(' ')).solve
      #puts "sub #{num}"
      @list = @list.drop(n + 1)
      #puts "newlist #{@list}"
    else
      num = @list.first.to_i
      @list = @list.drop(1)
    end
    num
  end

  def find_closing_paren
    level = 1
    num = 1
    lst = @list.clone
    lst.drop(1).each{|token|
      case token
      when '('
        level += 1
      when ')'
        level -= 1
        break num if level.zero?
      end
      num += 1
    }
    num
  end

end

class EquationWithPriority1 < Equation

  def initialize
    @part = 1
    super
  end

  def solve
    until @list.empty?
      #puts "list.f = #{@list.first}"
      case @list.first
      when '+'
        @list = @list.drop(1)
        cur += next_term
      when '*'
        @list = @list.drop(1)
        cur *= next_term
      else
        cur = next_term
      end
    end
    cur
  end
end

class EquationWithPriority2 < Equation

  def initialize
    @part = 2
    super
  end

  def solve
    #puts "solve2!"

    # Remove paren
    list2 = []
    until @list.empty?
      #puts "list.f = #{@list.first}"
      case @list.first
      when '+'
        @list = @list.drop(1)
        list2 += ['+']
      when '*'
        @list = @list.drop(1)
        list2 += ['*']
      else
        list2 += [next_term]
      end
    end

    #puts "list2a: #{list2}"
    list3 = list2.dup

    while list2.include?('+')
      list3 = []
      until list2.empty?
        if list2.length > 1 and list2[1] == '+'
          list3 += [list2[0].to_i + list2[2].to_i]
          list2 = list2.drop(3)
          #return Equation.new([list3] + [list2[0].to_i + list2[2].to_i] + list2.drop(3)).solve(nil, @part)
        else
          list3 += [list2.first]
          list2 = list2.drop(1)
        end
      end
      #puts "list3a #{list3}"
      list2 = list3.dup
    end

    #puts "list2b: #{list2}"
    #puts "list3: #{list3}"

    list3.reject{|e| e == '*'}.map{|e| e.to_i}.reduce(&:*)

  end
end
