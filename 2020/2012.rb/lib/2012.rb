# frozen_string_literal: true

# Manhattan
class Manhattan
  def initialize(list)
    @list = list.map{|line| parse(line)}
    @heading = 0
    @x = 0
    @y = 0
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def parse(line)
    m = /(?<ins>[A-Z]+)(?<num>\d+)/.match(line)
    [m['ins'], m['num'].to_i]
  end

  def step(ins, num)
    case ins
    when 'N'
      @y += num
    when 'E'
      @x += num
    when 'W'
      @x -= num
    when 'S'
      @y -= num
    when 'L'
      @heading = (@heading - num) % 360
    when 'R'
      @heading = (@heading + num) % 360
    when 'F'
      step({ 0 => 'E', 90 => 'S', 180 => 'W', 270 => 'N' }[@heading], num)
    end
  end

  def distance
    #puts "#{@list}"
    #puts "x,y : #{@x}, #{@y}  dx,dy : #{@dx}, #{@dy}"

    @list.each{|ins, num|
      step(ins, num)
      #puts "x,y : #{@x}, #{@y}  dx,dy : #{@dx}, #{@dy}"
    }

    @x.abs + @y.abs
  end
end

class Manhattan_waypoint < Manhattan

  def initialize(list)
    @dx = 10
    @dy = 1
    super
  end

  def step(ins, num)
    case ins
    when 'N'
      @dy += num
    when 'E'
      @dx += num
    when 'W'
      @dx -= num
    when 'S'
      @dy -= num
    when 'L'
      turn_clockwise(360 - num)
    when 'R'
      turn_clockwise(num)
    when 'F'
      @x += @dx * num
      @y += @dy * num
    end
  end

  def turn_clockwise(degrees)
    dx0 = @dx
    dy0 = @dy

    case degrees
    when 90
      @dx = dy0
      @dy = 0 - dx0
    when 180
      @dx = 0 - dx0
      @dy = 0 - dy0
    when 270
      @dx = 0 - dy0
      @dy = dx0
    end
  end
end
