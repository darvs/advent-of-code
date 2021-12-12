# frozen_string_literal: true

# ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn
class Cave
  attr_writer :visit_a_small_cave_twice

  def initialize(input)
    @visit_a_small_cave_twice = false

    p @map = input.map{|line| line.split('-')}.each_with_object(Hash.new([])){|pair, map|
      x, y = pair
      #p "pair #{pair} x #{x} y #{y} map #{map}"
      map[x] += [y]
      map[y] += [x]
      #p "map #{map}"
    }
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip))
  end

  def number_of_paths
    @paths = paths
    p "paths #{@paths}"
    @paths.length
  end

  def paths(current = 'start', acc = [])
    return (acc + ['end']).join('-') if current == 'end'

    p "paths #{current} #{acc}"

    acc += [current]
    @map[current].filter{|v|
      p "check #{v}, acc #{acc}"
      valid?(v, acc)
    }.each_with_object([]){|v, list|
      list << paths(v, acc.dup)
    }.flatten
  end

  def valid?(v, acc)
    @visit_a_small_cave_twice ? valid_part_2?(v, acc) : valid_part_1?(v, acc)
  end

  def valid_part_1?(v, acc)
    (v.upcase == v) || !acc.include?(v)
  end

  def valid_part_2?(v, acc)
    return true if v.upcase == v # Upper cases
    return true unless acc.include?(v) # We haven't see this cave before
    return false if v == 'start' && acc.length > 1 # start can't be there twice

    hhh = acc.filter{|w| w.upcase != w}.each_with_object(Hash.new(0)){|x, h|
      h[x] += 1
    }

    p "hhh #{hhh}"
    hhh.filter{|_, val| val == 2}.empty?
  end
end
