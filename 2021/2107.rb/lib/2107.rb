# frozen_string_literal: true

# The Treachery Of Whales
class TreacheryOfWhales
  def initialize(input)
    @list = input.sort
    @crab = false
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip).reduce(&:+).split(',').map(&:to_i))
  end

  def use_crab_engineering
    @crab = true
  end

  def run
    @crab ? run_crabful : run_crabless
  end

  def run_crabless
    (@list.min .. @list.max).map{|n|
      @list.map{|v|
        [n, (v - n).abs]
      }.each_with_object(Hash.new(0)){|p, h| h[p[0]] += p[1]}.map{|k,v| v}.flatten
    }.flatten.min
  end

  def run_crabful
    (@list.min .. @list.max).map{|n|
      @list.map{|v|
        distance = (v - n).abs
        [n, (0..distance).sum]
      }.each_with_object(Hash.new(0)){|p, h| h[p[0]] += p[1]}.map{|k,v| v}.flatten
    }.flatten.min
  end
end
