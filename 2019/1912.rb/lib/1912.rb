# frozen_string_literal: true

# A Single (and Lonely) Planet
class Planet
  attr_reader :x, :y, :z, :vx, :vy, :vz

  def initialize(coords)
    @x, @y, @z = coords
    @vx = @vy = @vz = 0
  end

  def apply_gravity(other)
    @vx += (other.x <=> @x)
    @vy += (other.y <=> @y)
    @vz += (other.z <=> @z)
  end

  def apply_velocity
    @x += @vx
    @y += @vy
    @z += @vz
  end

  def potential_energy
    @x.abs + @y.abs + @z.abs
  end

  def kinetic_energy
    @vx.abs + @vy.abs + @vz.abs
  end

  def energy
    potential_energy * kinetic_energy
  end

  def inspect
    "pos=<x=#{@x}, y=#{@y}, z=#{@z}> vel=<x=#{@vx}, y=#{@vy}, z=#{@vz}>"
  end
end

# A Planetary System
class PlanetarySystem
  def initialize(list)
    @planets = list
    #list.each{|x| p x}
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip)
      .map{|s| s.scan(/((?:-)?\d+)/).flatten.map(&:to_i)}
      .map{|coords| Planet.new(coords)})
  end

  def run(steps)
    (1..steps).each{
      @planets.permutation(2).each{|a, b| a.apply_gravity(b)}
      @planets.each(&:apply_velocity)
    }
  end

  def energy
    @planets.map(&:energy).reduce(&:+)
  end
end
