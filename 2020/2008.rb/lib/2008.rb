# frozen_string_literal: true

# CPU
class CPU
  attr_accessor :acc
  attr_accessor :pc

  def initialize(list)
    @program = []
    @pc = 0
    @acc = 0
    parse(list)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def parse(list)
    list.each{|line|
      op, arg = line.split(' ')
      @program += [Instruction.from_op(op, arg)]
    }
  end

  def run_next
    @program[@pc].execute(self)
  end
end

# A CPU instructions consists of an Operation and an Argument
class Instruction
  attr_reader :op, :arg

  def initialize(op, arg)
    @op = op
    @arg = arg
  end

  def self.from_op(op, arg)
    #puts "from_op #{op} #{arg}"
    case op
    when 'nop'
      NOP.new(op, arg.to_i)
    when 'acc'
      ACC.new(op, arg.to_i)
    when 'jmp'
      JMP.new(op, arg.to_i)
    end
  end

  def execute(cpu)
    #puts("Execute: #{cpu}")
    cpu.pc += 1
  end
end

class NOP < Instruction
end

# ACC sets the accumulator
class ACC < Instruction
  def execute(cpu)
    cpu.acc += @arg
    super
  end
end

# JMP is a relative jump
class JMP < Instruction
  def execute(cpu)
    cpu.pc += @arg
    # DON'T call super as it would change the PC
  end
end

# A debugger for our CPU
class Debugger < CPU
  def check_loop
    seen = Set.new
    puts "Program: #{@program}"
    until seen.include?(@pc)
      puts "PC:#{@pc} ACC:#{@acc} #{@program[@pc].op} #{@program[@pc].arg}"
      seen.add(@pc)
      run_next
      puts "PC:#{@pc} ACC:#{@acc}"
    end

    @acc
  end
end
