# frozen_string_literal: true

# Monster Grammar
class Grammar
  def initialize(lines)
    @rules = {}
    @messages = []
    parse(lines)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def parse(lines)
    until lines.empty? || lines.first.empty?
      m = /\A(?<lhs>\d+): (?<rhs>.+)\Z/.match(lines.first)
      #puts "lines.first #{lines.first} m #{m}"
      rhs_lst = m[:rhs].split('|')
                       .map{|rhs|
                         rhs.split(' ').map{|e| e[0] == '"' ? e[1..-2] : e.to_i}
                       }
      #puts "#{m[:lhs]} is #{m[:rhs]}"
      #puts "rhs_lst #{rhs_lst}"
      @rules[m[:lhs].to_i] = rhs_lst
      lines.slice!(0)
    end

    until lines.empty?
      @messages += [lines.first]
      lines.slice!(0)
    end

    puts "rules #{@rules}"
  end

  def check_message(msg)
    puts "----------------------------"
    puts "  #{msg}"
    puts "----------------------------"
    @msg = msg.dup
    ans = check_rule(0, @msg) && @msg.empty? ? 1 : 0
    puts ans.to_s
    ans
  end

  def check_rule(num, msg)
    rule = @rules[num]
    #msg = @msg.dup

    puts "num #{num} rule #{rule}"
    if rule.length == 1

      # A character
      if rule.flatten.first.is_a? String
        puts "a string @msg #{@msg} rule.f.f #{rule.flatten.first}"
        if @msg[0] == rule.flatten.first
          puts "true"
          @msg = @msg[1..-1]
          return true
        else
          puts "false"
          return false
        end
      else
        # A concatenation
        puts "concat #{rule.flatten}"
        return rule.flatten.all?{|r| check_rule(r, @msg)}
      end

    else

      # several parts separated with "|"
      return rule.any?{|r|
        @msg = msg.dup
        r.flatten.all?{|r2| check_rule(r2, @msg)}
      }
    end
  end

  def check_all_messages
    @messages.map{|msg| check_message(msg)}.sum
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
