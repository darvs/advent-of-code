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

  def sum_with_replacements
    @list = @list.map { |elem| replace(elem) }
    puts @list
    sum
  end

  def replace(str, repl='')
    return repl if str.empty?

    %w[one two three four five six seven eight nine]
      .each_with_index { |num, index|
        return replace(str[1..], repl + (index + 1).to_s) if str.start_with?(num)
      }

    replace(str[1..], repl + str[0])
  end
end
