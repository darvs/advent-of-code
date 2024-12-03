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
    @list = str.scan(/mul\(([0-9]{1,3}),([0-9]{1,3})\)|(do)\(\)|(don't)\(\)/)
  end

  def run(always_do: false)
    doing = true

    @list.map{|l|
      doing = true if l[2] == 'do'
      doing = false if l[3] == 'don\'t' && !always_do
      next 0 unless doing # we're not doing this one
      next 0 if l[0].nil? # element is a 'do' or 'dont', not numbers

      a, b = *l
      a.to_i * b.to_i
    }.sum
  end
end
