# frozen_string_literal: true

# ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn
class Polymer
  def initialize(input)
    #p "input #{input}"
    @polymer = input[0].chars

    @rules = input[1..].each_with_object(Hash.new('')){|s, h|
      m = s.match(/([A-Z])([A-Z]) -> ([A-Z])/)
      h[[m[1], m[2]]] = m[3]
    }
    #p "polymer #{@polymer} rules #{@rules}"
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip).reject(&:empty?))
  end

  def run(steps)
    (1..steps).each{
      inserts = (0..(@polymer.length - 2)).map{|i|
        @rules[[@polymer[i], @polymer[i + 1]]]
      }
      @polymer = @polymer.zip(inserts).flatten.reject(&:nil?)
      #p "polymer #{@polymer.reduce(&:+)}"
    }
    self
  end

  def to_s
    @polymer.reduce(&:+)
  end

  def most_common_minus_least_common
    counts = @polymer.each_with_object(Hash.new(0)){|l, h| h[l] += 1}
    count_list = counts.map{|_, v| v}

    p "counts #{counts}"
    count_list.max - count_list.min
  end

end
