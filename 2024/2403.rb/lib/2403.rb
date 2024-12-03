# frozen_string_literal: true

# Program
class Program
  def initialize(str)
    @list = []
    process(str)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip).join)
  end

  def process(str)
    @list = str.scan(/mul\(([0-9]{1,3}),([0-9]{1,3})\)/)
  end

  def run
    @list.map{|l|
      a, b = *l
      a.to_i * b.to_i
    }.sum
  end
end
