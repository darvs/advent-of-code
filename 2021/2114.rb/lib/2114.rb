# frozen_string_literal: true

# ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn
class Polymer
  def initialize(input)
    @str = input[0].chars
    @pairs = []
    @polymer = Hash.new(0)

    @rules = input[1..].sort.each_with_object(Hash.new({})){|s, h|
      m = s.match(/([A-Z])([A-Z]) -> ([A-Z])/)
      @pairs += [[m[1], m[2]]]
      h[1][[m[1], m[2]]] = { m[3] => 1 }
    }

    #p "pairs #{@pairs}"
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip).reject(&:empty?))
  end

  def run(steps)
    make_rules(steps) # Pre-compute the rules

    @polymer = @str.each_cons(2).map{|sub|
      @rules[steps][sub]
    }.each_with_object(Hash.new(0)){|amap, hash| amap.each{|k, v| hash[k] += v}}

    @str.each{|c| @polymer[c] += 1}

    self
  end

  # If n is number of steps and A, B and X symbols:
  # If    the starting string is AB
  # and   F(1, A, B) = X
  # then  After 1 step, the string is AXB
  # then  F(2, A, B) = A + F(1, A, X) + X + F(1, X, B) + B
  # and   F(n+1, A, B) = A + F(n, A, X) + X + F(n, X, B) + B
  def make_rules(steps)
    return if steps == 1 # First step is already defined

    (2..steps).each{|n|
      @rules[n] = {}

      @pairs.each{|a, b|
        center = @rules[1][[a, b]]
        x = center.keys[0]
        first = @rules[n - 1][[a, x]]
        last = @rules[n - 1][[x, b]]

        @rules[n][[a, b]] = [first, center, last].each_with_object(Hash.new(0)){|amap, h|
          amap.each{|k, v| h[k] += v}
        }
      }
    }

    #print_rules(steps)
  end

  def print_rules(steps)
    p "print rules #{steps}"

    (1..steps).each{|n|
      p "rule #{n} -----------------------"
      @rules[n].each{|k, v|
        puts "    #{k} => #{v}"
      }
    }
  end

  def most_common_minus_least_common
    count_list = @polymer.map{|_, v| v}
    count_list.max - count_list.min
  end
end
