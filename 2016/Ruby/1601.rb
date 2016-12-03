#!/usr/bin/env ruby

require 'set'

NORTH = 0
EAST  = 1
SOUTH = 2
WEST  = 3

ORIENTATION_STRING = %w(North East South West)

DIRECTION = [:left, :right]

class Position
  @x = 0
  @y = 0

  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def self.new_from_pos(pos)
    self.new(pos.x, pos.y)
  end

  def distance
    return @x.abs + @y.abs
  end

  def walk(heading)
    case heading.orientation
      when NORTH
        @y = @y + 1
      when SOUTH
        @y = @y - 1
      when EAST
        @x = @x + 1
      when WEST
        @x = @x - 1
    end
  end

  def to_s
    return "(#{@x}, #{@y})"
  end

  #
  # Comparable
  #

  def eql?(other)
    return (@x == other.x) && (@y == other.y)
  end

  def hash
    return @x ^ @y
  end

end

class Heading
  @orientation = NORTH

  def initialize(orientation)
    @orientation  = orientation
  end

  def turn(direction)
    orientation_change = (direction == :left) ? -1 : +1

    @orientation = (@orientation + orientation_change + 4) % 4

  end

  def orientation
    return @orientation
  end

  def to_s
    return ORIENTATION_STRING[@orientation]
  end
end

def AoC1601(input)

  position = Position.new(0,0)
  heading = Heading.new(NORTH)

  first_visited_twice = nil

  previous_positions = Set.new []

  puts("Position #{position} : Heading #{heading}")

  input.split(/\W+/).each do |instruction|

    heading.turn(instruction.start_with?("L") ? :left : :right)

    len = instruction[1..-1].to_i

    for _ in 0..len-1
      position.walk(heading)

      position_copy = Position.new_from_pos(position)
      if previous_positions.include?(position_copy)

        if first_visited_twice.nil?
          puts("We've been here already!")
          first_visited_twice = position_copy
        end

      else
        previous_positions.add(position_copy)
      end


    end

    puts("[#{instruction}] -> Position #{position} : Heading #{heading}")

  end

  puts("\nTotal distance is #{position.distance}")
  puts("Distance to first house visited twice is #{first_visited_twice.distance}")

end


# AoC1601("L2, R33, R2")

AoC1601("L4, L3, R1, L4, R2, R2, L1, L2, R1, R1, L3, R5, L2, R5, L4, L3, R2, R2, L5, L1, R4, L1, R3, L3, R5, R2, L5, R2, R1, R1, L5, R1, L3, L2, L5, R4, R4, L2, L1, L1, R1, R1, L185, R4, L1, L1, R5, R1, L1, L3, L2, L1, R2, R2, R2, L1, L1, R4, R5, R53, L1, R1, R78, R3, R4, L1, R5, L1, L4, R3, R3, L3, L3, R191, R4, R1, L4, L1, R3, L1, L2, R3, R2, R4, R5, R5, L3, L5, R2, R3, L1, L1, L3, R1, R4, R1, R3, R4, R4, R4, R5, R2, L5, R1, R2, R5, L3, L4, R1, L5, R1, L4, L3, R5, R5, L3, L4, L4, R2, R2, L5, R3, R1, R2, R5, L5, L3, R4, L5, R5, L3, R1, L1, R4, R4, L3, R2, R5, R1, R2, L1, R4, R1, L3, L3, L5, R2, R5, L1, L4, R3, R3, L3, R2, L5, R1, R3, L3, R2, L1, R4, R3, L4, R5, L2, L2, R5, R1, R2, L4, L4, L5, R3, L4")








