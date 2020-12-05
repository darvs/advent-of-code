# frozen_string_literal: true

# BoardingPasses
class BoardingPasses
  def initialize(list)
    @list = run(list)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def run(list)
    list.map{|p|
      p.chars.map{|bit| %w[B R].include?(bit) ? 1 : 0 }
       .reduce{|sum, n| sum * 2 + n}
    }
  end

  def highest
    @list.max
  end

  def mine
    (@list.min..@list.max).each{|n|
      break n unless @list.include?(n)
    }
  end
end
