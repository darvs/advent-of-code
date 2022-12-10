# frozen_string_literal: true

# Cathode-Ray Tube
class Crt
  def initialize(list)
    @list = list.map{|line| parse(line)}
    @x = 1
    @pc = 1
    @value_changes = {}
    @value_changes[0] = 1
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:chomp))
  end

  def parse(line)
    s = line.split
    [s.first, s.length > 1 ? s[1].to_i : nil]
  end

  def exec(ins, arg)
    case ins
    when 'noop'
      @pc += 1
    when 'addx'
      @pc += 2
      @x += arg
      @value_changes[@pc] = @x
    end
  end

  def run
    @list.each{|ins, arg| exec(ins, arg)}
    p @value_changes
    self
  end

  def reg_x_during(cycle)
    @value_changes[@value_changes.keys.filter{|at| at <= cycle}.max]
  end

  def strength_during(cycle)
    p "str cycle #{cycle} reg_x #{reg_x_during(cycle)}"
    reg_x_during(cycle) * cycle
  end

  def draw
    disp = Array.new(240, ' ')
    (1..240).each{|cycle|
      disp[cycle - 1] = '#' if ((reg_x_during(cycle) + 1) - (((cycle - 1) % 40) + 1)).abs <= 1
    }

    puts
    6.times{|n|
      puts disp.slice(n * 40, 40).join
    }
    puts
  end

  def sum_of_interesting_strengths
    draw
    [20, 60, 100, 140, 180, 220].map{|cycle|
      strength_during(cycle)
    }.sum
  end
end
