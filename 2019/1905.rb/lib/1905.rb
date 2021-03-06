# frozen_string_literal: true

# An interpreter for Intcode programs
class IntcodeInterpreter
  ADD = 1
  MUL = 2
  INP = 3
  OUT = 4
  BNE = 5
  BEQ = 6
  LT  = 7
  EQ  = 8
  BRK = 99

  MODE_POSITION = 0
  MODE_IMMEDIATE = 1

  def initialize(string)
    @code = string.split(',')
                  .map(&:to_i)
                  .to_a
    @pc = 0
    @ins = 0
    @modes = 0
    @input = []
    @output = []
  end

  def self.read_file(filename)
    File.read(File.join('data', filename)).strip
  end

  def self.from_file(filename)
    new(read_file(filename))
  end

  def input=(val)
    @input = val.split(',').map(&:to_i).to_a
  end

  def output
    @output.join(',')
  end

  def error=(val)
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

  def debug
    "pc #{@pc} ins #{@ins} modes #{@modes} input #{@input.join(',')} output #{@output.join(',')} code #{@code.join(',')}"
  end

  def read
    old = @pc
    @pc += 1
    @code[old]
  end

  def fetch(val)
    mode = @modes % 10
    @modes /= 10

    case mode
    when MODE_POSITION then peek(val)
    when MODE_IMMEDIATE then val
    end
  end

  def peek(pos)
    @code[pos]
  end

  def poke(pos, val)
    @code[pos] = val
  end

  def add
    a = fetch(read)
    b = fetch(read)
    poke(read, a + b)
  end

  def mul
    a = fetch(read)
    b = fetch(read)
    poke(read, a * b)
  end

  def inp
    a = @input.shift
    poke(read, a)
  end

  def out
    a = fetch(read)
    #puts "out: #{a}"
    @output << a
  end

  def bne
    a = fetch(read)
    b = fetch(read)
    @pc = b unless a.zero?
  end

  def beq
    a = fetch(read)
    b = fetch(read)
    @pc = b if a.zero?
  end

  def lt
    a = fetch(read)
    b = fetch(read)
    poke(read, a < b ? 1 : 0)
  end

  def eq
    a = fetch(read)
    b = fetch(read)
    #p ["eq a:#{a} b:#{b}"]
    poke(read, a == b ? 1 : 0)
  end

  def run
    loop do
      word = read
      @ins = word % 100
      @modes = word / 100
      #p ['run', debug]
      break if @ins == BRK

      case @ins
      when ADD then add
      when MUL then mul
      when INP then inp
      when OUT then out
      when BEQ then beq
      when BNE then bne
      when LT  then lt
      when EQ  then eq
      end
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
