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
    seen = {}
    @list.each.with_index{|x, i|
      seen[x] = i
    }
    last = 0

    (@list.length..n - 2).each{|i|
      last_seen = seen[last]
      seen[last] = i
      last = last_seen.nil? ? 0 : i - last_seen
    }

    last
  end
end
