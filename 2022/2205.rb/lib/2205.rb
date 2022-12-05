# frozen_string_literal: true

# Supply Stacks
class Stacks
  def initialize(list)
    @stacks = parse_stacks(list)
    @moves = parse_moves(list)
  end

  def parse_stacks(list)
    list.take_while{|x| !x.empty?}
        .map(&:chars)
        .transpose
        .map(&:reverse)
        .filter{|x| x.first =~ /\d+/}
        .map{|x|
          x.drop(1)
           .reverse
           .drop_while{|f| f == ' '}
        }
  end

  def parse_moves(list)
    list.map{|l| l.match('(\d+) from (\d) to (\d)')}
        .reject(&:nil?)
        .map{|l| l[1..3].map(&:to_i)}
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:chomp))
  end

  def run9000
    @moves.each{|m|
      (1..m[0]).each{
        x = @stacks[m[1] - 1].shift
        @stacks[m[2] - 1].unshift(x)
      }
    }
  end

  def run9001
    @moves.each{|m|
      x = @stacks[m[1] - 1].shift(m[0])
      @stacks[m[2] - 1].unshift(x).flatten!
    }
  end

  def ends_up_as(mover)
    mover.eql?(9000) ? run9000 : run9001
    @stacks.map(&:first).reduce(&:+)
  end
end
