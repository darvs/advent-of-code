# frozen_string_literal: true

# ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn
class Origami

  def initialize(input)
    ins_s, points = input.partition{|line| line.start_with?('fold')}

    @points = points.map{|s| s.split(',').map(&:to_i)}.to_set

    @ins = ins_s.map{|s|
      m = s.match(/fold along (x|y)=(\d+)/)
      [m[1].to_sym, m[2].to_i]
    }
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip).reject(&:empty?))
  end

  def limit(n)
    @ins = @ins.take(n)
  end

  def fold
    @ins.each{|along, at| along == :x ? fold_x(at) : fold_y(at)}
  end

  def fold_x(at)
    @points = @points.each_with_object(Set.new){|pt, set|
      x, y = pt
      set.add(x < at ? pt : [at - (x - at), y])
    }
  end

  def fold_y(at)
    @points = @points.each_with_object(Set.new){|pt, set|
      x, y = pt
      set.add(y < at ? pt : [x, at - (y - at)])
    }
  end

  def dots
    @points.length
  end

  def display
    max_x = @points.map{|x, _| x}.max
    max_y = @points.map{|_, y| y}.max

    hash = @points.each_with_object(Hash.new('.')){|pt, h|
      x, y = pt
      h[[x, y]] = '#'
    }

    (0..max_y).each{|y|
      p (0..max_x).map{|x| hash[[x, y]]}.reduce(&:+)
    }
  end
end
