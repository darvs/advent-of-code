# frozen_string_literal: true

# Dive!
class Dive
  def initialize(list)
    @list = list
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map{|x| x.strip.split(' ')})
  end

  def part2
    aim = 0
    pos = 0
    depth = 0
    @list.each{|ins, val_s|
      val = val_s.to_i
      case ins
      when 'down'
        aim += val
      when 'up'
        aim -= val
      when 'forward'
        pos += val
        depth += (aim * val)
      end
    }
    pos * depth
  end
end
