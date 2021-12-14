# frozen_string_literal: true

# ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn
class Polymer
  def initialize(input)
    #p "input #{input}"
    @str = input[0].chars
    @pairs = []

    @rules = input[1..].sort.each_with_object(Hash.new({})){|s, h|
      m = s.match(/([A-Z])([A-Z]) -> ([A-Z])/)
      @pairs += [[m[1], m[2]]]
      h[1][[m[1], m[2]]] = { m[3] => 1 }
    }

    p "pairs #{@pairs}"
    p "rules init #{@rules[1]}"
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip).reject(&:empty?))
  end

  def run(steps)
    #p 'run begin'
    make_rules(steps)

    #init_hash = Hash.new(0)
    #@str.each{|c| init_hash[c] += 1}

    @polymer = solve(@str, steps)
    
    # Add the initial string
    @str.each{|c| @polymer[0][c] += 1}


    #p "run #{@polymer}"
    self
  end

  def solve(list, steps)
    #p "solve #{steps} #{list}"
    inserts = (0..(list.length - 2)).map{|i|
      @rules[steps][[list[i], list[i + 1]]]
    }
    p "list #{list} inserts #{inserts}"
    #list.zip(inserts).flatten.reject(&:nil?).reduce(&:+).chars
    sol = Hash.new(0)
    inserts.each{|ins| ins.each{|k, v| sol[k] += v}}

    [sol]
  end

  def make_rules(steps)
    return if steps == 1

    (2..steps).each{|n|
      @rules[n] = {}
      p "make rules #{n} #{Time.new}"

      @pairs.each{|x, y|
        center = solve([x, y], 1)[0].keys[0] #.reduce(&:+)[1..-2]
        first = @rules[n - 1][[x, center]]
        last = @rules[n - 1][[center, y]]

        p "first #{first} center #{center} last #{last}"

        big_hash = Hash.new(0)
        first.each{|k, v| big_hash[k] += v}
        p "center #{center} big_hash #{big_hash}"
        big_hash[center] += 1
        last.each{|k, v| big_hash[k] += v}

        @rules[n][[x, y]] = big_hash
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

    p "the final polymer #{@polymer}"
    #counts = @polymer.each_with_object(Hash.new(0)){|l, h| h[l] += 1}
    count_list = @polymer[0].map{|_, v| v}

    p "count_list #{count_list}"

    count_list.max - count_list.min
  end
end
