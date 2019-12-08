# frozen_string_literal: true

require '1905.rb'

# This is a multi-cpu Intcode Interpreter
class MultiCPUIntcodeInterpreter
  def initialize(string)
    @pgm = string
    @input = []
    @output = []
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

  def input=(val)
    with_input(val)
  end

  def output
    @output.join(',')
  end

  def run_program(input1, input2)
    IntcodeInterpreter.new(@pgm).with_input([input1, input2].join(',')).run
  end

  def seq
    (1..5).each.inject(0){|out| run_program(@input.shift, out).output.to_i}
  end

  def self.max_thruster_signal(program)
    [0, 1, 2, 3, 4].permutation.map{|settings|
      MultiCPUIntcodeInterpreter.new(program).with_input(settings.join(',')).seq
    }.max
  end

  def self.feedback_loop(program, seq_string)
    cpu = Array.new(5) {IntcodeInterpreter.new(program)}
    seq_string.split(',').each.with_index{|v, i|
      cpu[i].add_input(v)
    }

    out = [0]
    loop do
      cpu.each{|c|
        out.each{|n| c.add_input(n)}
        out = c.run.output.split(',').map(&:to_i)
      }
      break if cpu.map(&:state).select{|s| s == :terminated}.count.eql?(5)
    end
    out.first
  end

  def self.all_settings_feedback_loop(program)
    [5, 6, 7, 8, 9].permutation.map{|settings|
      feedback_loop(program, settings.join(',')).to_i
    }.max
  end
end
