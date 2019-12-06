# frozen_string_literal: true

# Universal Orbit Map
class Orbits
  def initialize(filename)
    orbits = File.open(File.join('data', filename))
                 .map(&:strip)
                 .map{|line| line.split(')').to_a}

    unique_objects = orbits.flatten.to_set
    root = unique_objects.difference(orbits.map{|_, y| y}).first

    @distance = {}
    @paths = {}
    parse(orbits, root)

    #p ['distance', @distance]
    #p ['paths', @paths]
  end

  def parse(orbits, root, path = [], dist = 0)
    orbits.select{|x, _| x == root}.each{|_, y|
      parse(orbits, y, path.dup << root, dist + 1)
    }

    @paths[root] = path.dup.reverse
    @distance[root] = dist
  end

  def number_of_orbits
    @distance.map{|_, v| v}.reduce(&:+)
  end

  def min_orbital_transfers(one, two)
    common_root = @paths[one].select{|x| @paths[two].include?(x)}.first

    @paths[one].index(common_root) + @paths[two].index(common_root)
  end
end
