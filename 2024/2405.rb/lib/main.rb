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

    # p "before_after: #{@before_after}"
    # p "manual: #{@manual}"

    @before_after.each{|pair|
      a, b = *pair
      @biggar[b] += [a]
    }
    # p "biggar: #{@biggar}"
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

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

  def fix
    @manual.reject{|m|
      check_line(m)
    }
           .map{|line| fix_line(line)}
           .map{|line| line[line.length / 2]}
           .sum
  end

  def fix_line(line)
    len = line.length
    (0..len - 2).each{|n|
      (n + 1..len - 1).each{|m|
        next if check_pair(line[n], line[m])

        tmp = line[m]
        line[m] = line[n]
        line[n] = tmp
      }
    }
    line
  end


end
