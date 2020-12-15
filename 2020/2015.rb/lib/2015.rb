# frozen_string_literal: true

# ElvesGame
class ElvesGame
  def initialize(list)
    @list = list
  end

  def self.from_list(list)
    new(list.split(',').map{|n| n.to_i}.reverse)
  end

  def run(n)
    run_list(n - @list.length, @list)
  end

  def run_list(n, list)
    #puts "#{n} #{list}"
    return list.first if n.zero?

    head = list.first
    rest = list.drop(1)

    index = rest.find_index(head)
    if index.nil?
      run_list(n - 1, [0] + list)
    else
      run_list(n - 1, [index+1] + list)
    end
  end
end
