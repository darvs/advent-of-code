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
    #puts "x,y : #{@x}, #{@y}  wx,wy : #{@wx}, #{@wy}"

    @list.each{|ins, num| 
      step(ins, num)
      #puts "x,y : #{@x}, #{@y}  wx,wy : #{@wx}, #{@wy}"
    }

    @x.abs + @y.abs
  end
end

class Manhattan_waypoint < Manhattan

  def initialize(list)
    @wx = 10
    @wy = 1
    super
  end

  def step(ins, num)
    case ins
    when 'N'
      @wy += num
    when 'E'
      @wx += num
    when 'W'
      @wx -= num
    when 'S'
      @wy -= num
    when 'L'
      turn_clockwise(360 - num)
    when 'R'
      turn_clockwise(num)
    when 'F'
      dx = @wx - @x
      dy = @wy - @y

      @x += dx * num
      @y += dy * num

      @wx = @x + dx
      @wy = @y + dy
    end
  end

  def turn_clockwise(degrees)
    dx = @wx - @x
    dy = @wy - @y

    case degrees
    when 90
      @wx = @x + dy
      @wy = @y - dx
    when 180
      @wx = @x - dx
      @wy = @y - dy
    when 270
      @wx = @x - dy
      @wy = @y + dx
    end
  end
end
