# frozen_string_literal: true

# frozen_string_literal: true

# Lanternfish
class Lanternfish
  def initialize(input)
    @list = input
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip).reduce(&:+).split(',').map(&:to_i))
  end

  def run(days)
    (1..days).each{
      #p @list
      births = @list.filter(&:zero?).count
      #p "births = #{births}"
      @list = [@list.map{|countdown| countdown.zero? ? 6 : countdown - 1}, births.times.map{8}].flatten
      #p "-> #{@list}"
    }

    @list.count
  end
end
