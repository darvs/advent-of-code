# frozen_string_literal: true

# Mirage
class Mirage
  def initialize(lines)
    @lines = Array.new(lines)
    @lines = parse_lines
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def parse_lines
    @lines.map{|line|
      line.split(' ').map(&:to_i)
    }
  end

  def compute_last(line)
    return line.first if line.tally.count == 1

    deltas = line.each_cons(2).map{|a, b| b - a}
    # puts "deltas #{deltas}"

    line.last + compute_last(deltas)
  end

  def total
    # puts "lines #{@lines}"
    @lines.map{|l| compute_last(l)}.sum
  end

  def compute_first(line)
    return line.first if line.tally.count == 1

    deltas = line.each_cons(2).map{|a, b| b - a}
    #puts "deltas #{deltas}"

    #puts "line.first #{line.first}"
    line.first - compute_first(deltas)
  end

  def total_first
    @lines.map{|l| compute_first(l)}.sum
  end
end
