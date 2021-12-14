# frozen_string_literal: true

# ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn
class Polymer
  def initialize(input)
    #p "input #{input}"
    @polymer = input[0].chars

    @rules = input[1..].sort.each_with_object(Hash.new({})){|s, h|
      m = s.match(/([A-Z])([A-Z]) -> ([A-Z])/)
      h[1][[m[1], m[2]]] = m[3]
    }

    p "rules init #{@rules[1]}"
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip).reject(&:empty?))
  end

  def run(steps)
    p "run begin"
    make_rules(steps)

    @polymer = solve(@polymer, steps)

    #p "run #{@polymer}"
    self
  end

  def solve(list, steps)
    p "solve #{steps} #{list}"
    inserts = (0..(list.length - 2)).map{|i|
      @rules[steps][[list[i], list[i + 1]]]
    }
    list.zip(inserts).flatten.reject(&:nil?).reduce(&:+).chars
  end

  def make_rules(steps)
    return if steps == 1

    (2..steps).each{|n|
      @rules[n] = {}
      p "make rules #{n} #{Time.new}"

      old_rules = @rules[n - 1].dup

      old_rules.each{|list, result|
        x, y = list
        new_list = [x, result.chars, y].flatten
        sol = solve(new_list, 1).reduce(&:+)[1..-2]
        @rules[n][[x, y]] = sol
        #@rules[1][new_list] = sol.dup
      }
    }

    print_rules(steps)
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

  def to_s
    @polymer.reduce(&:+)
  end

  def most_common_minus_least_common
    counts = @polymer.each_with_object(Hash.new(0)){|l, h| h[l] += 1}
    count_list = counts.map{|_, v| v}

    count_list.max - count_list.min
  end
end
