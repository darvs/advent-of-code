# frozen_string_literal: true

# Trebuchet
class Trebuchet
  def initialize(list)
    @list = list
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def sum
    @list.map { |elem| elem.chars.filter { |c| c.match?('\d') } }
         .map { |num_list| (num_list[0] + num_list[-1]).to_i }.sum
  end
end
