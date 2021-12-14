# frozen_string_literal: true

# ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn
class Polymer
  def initialize(input)
    #p "input #{input}"
    @polymer = input[0].chars

    @rules = input[1..].sort.each_with_object(Hash.new('')){|s, h|
      m = s.match(/([A-Z])([A-Z]) -> ([A-Z])/)
      h[[m[1], m[2], 1]] = m[3]
    }
    p "polymer #{@polymer} rules #{@rules}"
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip).reject(&:empty?))
  end

  #def run(steps)
    #make_rules(steps)

    #(1..steps).each{
      #inserts = (0..(@polymer.length - 2)).map{|i|
        #@rules[[@polymer[i], @polymer[i + 1], 1]]
      #}
      #@polymer = @polymer.zip(inserts).flatten.reject(&:nil?)
      ##p "polymer #{@polymer.reduce(&:+)}"
    #}
    #self
  #end

  def run(steps)
    make_rules(steps)

    p "RUN/TIME #{@polymer}"

    #inserts = (0..(@polymer.length - 2)).map{|i|
      #@rules[[@polymer[i], @polymer[i + 1], steps]]
    #}
    #@polymer = @polymer.zip(inserts).flatten.reject(&:nil?)
    @polymer = solve(@polymer, steps)

    p "RUN/TIME #{@polymer}"
    self
  end

  def solve(list, steps)
    p "solve for #{list}, #{steps}"
    inserts = (0..(list.length - 2)).map{|i|
      @rules[[list[i], list[i + 1], steps]]
    }
    list.zip(inserts).flatten.reject(&:nil?).reduce(&:+).chars
  end

    

  def make_rules(steps)
    return if steps == 1

    p "make rules #{steps} #{@rules}"

    (2..steps).each{|n|
      @rules.filter{|v, _|
        _, _, level = v
        level == n - 1
      }.each{|left_part, result|
        p "checking out #{left_part}, #{result}"
        #print_rules
        x, y = left_part
        a = @rules[[x, result[0], 1]]
        b = @rules[[result[-1], y, 1]]
        p "x, y, n #{x},#{y},#{n} [#{a}, #{result}, #{b}]"

        #@rules[[x, y, n]] = [a, result, b].reduce(&:+)
        @rules[[x, y, n]] = solve([x, result.chars, y].flatten, 1).reduce(&:+)[1..-2]
      }
    }

    print_rules
  end

  def print_rules
    @rules.each{|left, right|
      a, b, level = left
      p "#{level}: #{a}, #{b} -> #{right}"
    }
  end

  def to_s
    @polymer.reduce(&:+)
  end

  def most_common_minus_least_common
    p "final polymer #{@polymer}"
    counts = @polymer.each_with_object(Hash.new(0)){|l, h| h[l] += 1}
    count_list = counts.map{|_, v| v}

    p "counts #{counts}"
    count_list.max - count_list.min
  end
end
