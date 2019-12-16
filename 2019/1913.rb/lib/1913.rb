# frozen_string_literal: true

# An arcade emulator class
class Mame
  SPRITES = ' |#-o'

  def initialize(intcode_output)
    @out = intcode_output.each_slice(3)
                         .each_with_object(Hash.new(0)){|coords, screen|
      x, y, c = coords
      #p [:x, x, :y, y, :c, c]
      screen[[x, y]] = SPRITES[c]
    }
  end

  def display
    xres = @out.keys.map{|x, _| x}.max
    yres = @out.keys.map{|_, y| y}.max
    screen = (0..yres).map{|y|
      (0..xres).map{|x| @out[[x, y]]}.join
    }
    screen.each{|line| p line}
  end

  def count_blocks
    @out.select{|_, val| val == '#'}.count
  end
end
