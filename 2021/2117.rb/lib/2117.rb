# frozen_string_literal: true

# ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn
class Shooter
  attr_reader :apex_val
  attr_reader :hit_count

  def initialize(string)
    m = /target area: x=((?:-)?\d+)..((?:-)?\d+), y=((?:-)?\d+)..((?:-)?\d+)/.match(string)
    @min_x, @max_x, @min_y, @max_y = m[1..].map(&:to_i)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip).reject(&:empty?).join)
  end

  def run
    probe_min_y = @min_y
    probe_min_x = 1
    probe_max_x = @max_x
    probe_max_y = @max_x

    @apex_coords = []
    @apex_val = 0
    @hits = Set.new

    (probe_min_y..probe_max_y).each{|dy0|
      (probe_min_x..probe_max_x).each{|dx0|
        #p "dx0 #{dx0} dy0 #{dy0}"
        x = 0
        y = 0
        local_apex = 0
        dx = dx0
        dy = dy0
        loop {
          x += dx
          y += dy
          dx += dx.zero? ? 0 : dx0.positive? ? -1 : 1
          dy -= 1

          local_apex = y if y > local_apex

          # We hit the target
          if x.between?(@min_x, @max_x) &&
             y.between?(@min_y, @max_y)

            @hits << [dx0, dy0]

            if local_apex > @apex_val
              @apex_val = local_apex
              @apex_coords = [x, y]
            end
          end

          break if y < @min_y || x > @max_x
        }
      }
    }
    #p "coords: #{@apex_coords}"
    #p "apex: #{@apex_val}"

     @hit_count = @hits.count

    #p "number of hits #{@hit_count}"

    self
  end

end
