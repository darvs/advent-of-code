# frozen_string_literal: true

# ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn
class Cave
  def initialize(input)
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
      (v.upcase == v) || !acc.include?(v)}.each_with_object([]){|v, list|
        list << paths(v, acc.dup)
    }.flatten
  end
end
