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

  def run
    p 'run'
    @moves.each{|m|
      p "m #{m}"
      (1..m[0]).each{
        x = @stacks[m[1] - 1].shift
        @stacks[m[2] - 1].unshift(x)

        p "s #{@stacks}"
      }
    }
  end

  def ends_up_as
    p @stacks
    p @moves

    run

    p @stacks

    @stacks.map(&:first).reduce(&:+)
  end
end
