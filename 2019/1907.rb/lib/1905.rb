#frozen_string_literal: true

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

  attr_reader :state, :input

  def initialize(string)
    @code = string.split(',')
                  .map(&:to_i)
                  .to_a
    @pc = 0
    @ins = 0
    @modes = 0
    @input = []
    @output = []

    @state = :loaded
  end

  def self.read_file(filename)
    File.read(File.join('data', filename)).strip
  end

  def self.from_file(filename)
    new(read_file(filename))
  end

  def with_input(val)
    @input = val.split(',').map(&:to_i).to_a
    self
  end

  def with_add_input(val)
    @input << val.to_i
    self
  end

  def input=(val)
    with_input(val)
  end

  def output
    resp = @output.join(',')
    @output = []
    resp
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
    #p ['code', @code]
    a = fetch(read)
    b = fetch(read)
    #p [:a, a, :b, b]
    poke(read, a * b)
  end

  def inp
    if @input.empty?
      #p ['wait for input']
      @state = :wait_for_input
      return
    end
    @state = :running

    a = @input.shift
    #p ['read input', a, 'remaining', @input]
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

  def brk
    @state = :terminated
  end

  def run
    @state = :running if @state == :loaded

    until @state == :terminated
      unless @state == :wait_for_input
        word = read
        @ins = word % 100
        @modes = word / 100
      end
      #p ['run', debug]

      case @ins
      when ADD then add
      when MUL then mul
      when INP then inp
      when OUT then out
      when BEQ then beq
      when BNE then bne
      when LT  then lt
      when EQ  then eq
      when BRK then brk
      end

      break if @state == :wait_for_input
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
