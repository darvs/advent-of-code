# frozen_string_literal: true

# Dive!
class Dive
  def initialize(list)
    @list = list
    @use_aim = false
    @aim = 0
    @pos = 0
    @depth = 0
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map{|x| x.strip.split(' ')})
  end

  def use_aim
    @use_aim = true
  end

  def run
    @list.each{|ins, val_s|
      val = val_s.to_i
      @use_aim ? with_aim(ins, val) : without_aim(ins, val)
    }
    @pos * @depth
  end

  def without_aim(ins, val)
    case ins
    when 'down'
      @depth += val
    when 'up'
      @depth -= val
    when 'forward'
      @pos += val
    end
  end

  def with_aim(ins, val)
    case ins
    when 'down'
      @aim += val
    when 'up'
      @aim -= val
    when 'forward'
      @pos += val
      @depth += (@aim * val)
    end
  end
end
