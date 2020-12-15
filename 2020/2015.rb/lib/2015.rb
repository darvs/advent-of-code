# frozen_string_literal: true

# ElvesGame
class ElvesGame
  def initialize(list)
    @list = list
  end

  def self.from_list(list)
    new(list.split(',').map(&:to_i))
  end

  def run(n)
    seen = Hash.new
    i = 0
    @list[0..-2].each{|x|
      seen[x] = i
      i += 1
    }
    last = @list[-1]
    puts "# #{i} last #{last} seen #{seen}"

    while i < n - 1
      x = seen[last]
      seen[last] = i
      last = x.nil? ? 0 : i - x
      #puts "+ #{last}"
      i += 1
    end

    puts seen.to_s
    last
  end
end
