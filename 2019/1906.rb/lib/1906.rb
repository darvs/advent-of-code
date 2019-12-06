# frozen_string_literal: true

# Universal Orbit Map
class Orbits
  def initialize(filename)
    @objects = []
    @orbits = File.open(File.join('data', filename))
                  .map(&:strip)
                  .map{|line| line.split(')').to_a}
    p @orbits

    @orbits.each{|orb|
      @objects << orb[0]
      @objects << orb[1]
    }

    # ------------------
    # Get unique objects
    # ------------------
    @objects.sort!.uniq!

    p @objects

    # ------------------
    # Find root
    # ------------------

    # init object count
    root_list = Set.new
    @objects.each{|obj| root_list << obj}

    @orbits.each{|orb| root_list.delete(orb[1])}

    @root = root_list.to_a[0]

    p ['root_list', @root]

    @distance = Hash.new(0)
    @paths = Hash.new
    parse(@root)

    p ['distance', @distance]
    p ['paths', @paths]
  end

  def parse(local_root, path = [], dist = 1)
    orbiters = @orbits.select{|o| o[0] == local_root}

    unless orbiters.empty?
      orbiters.each{|orb|
        @distance[orb[1]] = dist
        #p ['local_root', local_root, 'path', path]
        @paths[local_root] = path.dup.reverse
        parse(orb[1], path.dup << local_root, dist + 1)
      }
    else
      @paths[local_root] = path.dup.reverse
      #p ['local_root', local_root, 'path', path.dup << local_root]
    end
  end

  def number_of_orbits
    @distance.map{|k, v| v}.reduce(&:+)
  end

  def min_orbital_transfers(one, two)
    common_root = ""
    @paths[one].each{|possible_root|
      common_root = possible_root
      break if @paths[two].find_index{|e| e == possible_root}
    }
    p ['common_root', common_root]

    @paths[one].find_index{|e| e == common_root} + @paths[two].find_index{|e| e == common_root}

  end

  0
end
