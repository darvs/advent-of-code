# frozen_string_literal: true

# Lanternfish
class Lanternfish
  def initialize(input)
    @list = input
    @fish = Hash.new(0)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip).reduce(&:+).split(',').map(&:to_i))
  end

  def run(days)
    # Initial fish giving birth

    @list.each{|f|
      d = f + 1

      while d <= days
        @fish[d] += 1
        d += 7
      end
    }

    # Every fish born during the simulation

    (0..days).each{|birth|
      d = birth + 9

      while d <= days
        @fish[d] += @fish[birth]
        d += 7
      end
    }

    @list.count + @fish.map{|_, v| v}.sum
  end
end
