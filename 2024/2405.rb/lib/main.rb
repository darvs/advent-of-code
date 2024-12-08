# frozen_string_literal: true

# Program
class Program
  def initialize(list)
    @before_after = []
    @biggar = Hash.new([])
    @sequence = []
    @manual = []

    list.each{|line|
      #puts line
      @before_after += [line.split('|').map(&:to_i)] if line.chars.include?('|')
      @manual += [line.split(',').map(&:to_i)] if line.chars.include?(',')
    }

    p "before_after: #{@before_after}"
    p "manual: #{@manual}"
    # build_sequence
    #
    @before_after.each{|pair|
      a, b = *pair
      @biggar[b] += [a]
    }
    p "biggar: #{@biggar}"
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  # def build_sequence
  #   after = @before_after.map{|pair| pair[1]}.to_set
  #   p "after: #{after.to_a.sort}"
  #
  #   # p "before_after: #{@before_after}"
  #   while @before_after.length > 1
  #     p "b_a_l: #{@before_after.length}"
  #     before = @before_after.map{|pair| pair[0]}.to_set
  #     p "before: #{before.to_a.sort}"
  #
  #     last = (after - before).to_a[0]
  #     # p "last: #{last}"
  #
  #     after.delete(last)
  #     @sequence += [last]
  #     @before_after.reject!{|p| p[1] == last}
  #   end
  #
  #   @sequence += @before_after.first.reverse
  #   @sequence.reverse!
  #
  #   p "before_after: #{@before_after}"
  #   p "sequence: #{@sequence}"
  # end

  # def run
  #   @manual.select{|man|
  #     #p "man: #{man}"
  #     man.map{|m| @sequence.find_index{|s| m == s}}
  #       .each_cons(2).all?{|a, b| a <= b}
  #   }.map{|arr| arr[arr.length / 2]}.sum
  # end

  def run
    @manual.select{|m|
      check_line(m)
    }.map{|list| list[list.length / 2]}.sum
  end

  def check_line(line)
    len = line.length
    (0..len - 2).each{|n|
      (n + 1..len - 1).each{|m|
        return false unless check_pair(line[n], line[m])
      }
    }
    true
  end

  def check_pair(a, b)
    #p "check_pair #{a} #{b}"
    #p "biggar[#{b}] #{@biggar[b]}"
    @biggar[b].include?(a)
  end
end
