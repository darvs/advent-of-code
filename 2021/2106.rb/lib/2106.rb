# frozen_string_literal: true

# frozen_string_literal: true

# Lanternfish
class Lanternfish
  def initialize(input)
    @list = input
    @fish = 0
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip).reduce(&:+).split(',').map(&:to_i))
  end

  def run(days)
    @list.each{|countdown| fish(days - countdown - 1, 0)}
    @fish
  end

  def fish(countdown, delay)
    @fish += 1
    countdown -= delay

    while countdown >= 0
      countdown -= 7
      fish(countdown, 2)
    end
  end
end
