# frozen_string_literal: true

# An interpreter for Intcode programs
class IntcodeInterpreter
  ADD = 1
  MUL = 2
  BRK = 99

  def initialize(string)
    @code = string.split(',')
                  .map(&:to_i)
                  .to_a
    @pc = 0
  end

  def self.read_file(filename)
    File.read(File.join('data', filename)).strip
  end

  def self.from_file(filename)
    new(read_file(filename))
  end

  def set_error_val(val)
    set_error(val / 100, val % 100)
  end

  def set_error(noun, verb)
    poke(1, noun)
    poke(2, verb)
    self
  end

  def to_s
    @code.join(',')
  end

  def read
    old = @pc
    @pc += 1
    @code[old]
  end

  def peek(pos)
    @code[pos]
  end

  def poke(pos, val)
    @code[pos] = val
  end

  def add
    a = peek(read)
    b = peek(read)
    poke(read, a + b)
  end

  def mul
    a = peek(read)
    b = peek(read)
    poke(read, a * b)
  end

  def run
    ins = read
    while ins != BRK
      case ins
      when ADD
        add
      when MUL
        mul
      end
      ins = read
    end
    #puts "PC: #{@pc}, CODE: #{@code}"
    self
  end

  def self.loop(filename, pos, val)
    data = read_file(filename)
    (0..99).each do |noun|
      (0..99).each do |verb|
        #puts "noun #{noun} verb #{verb}"
        if new(data).set_error(noun, verb).run.peek(pos) == val
          return (noun * 100 + verb)
        end
      end
    end
  end
end
