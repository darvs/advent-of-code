# frozen_string_literal: true

# BoardingPasses
class BoardingPasses
  def initialize(list)
    @list = run(list)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def run(list)
    list.map{|p|
      strrow = p[0, 7]
      strcol = p[7, 3]

      row = 0
      strrow.chars{|c|
        row *= 2
        row += c == 'B' ? 1 : 0
      }

      col = 0
      strcol.chars{|c|
        col *= 2
        col += c == 'R' ? 1 : 0
      }

      row * 8 + col
    }
  end

  def highest
    @list.max
  end

  def mine
    (@list.min..@list.max).each{|n|
      break n unless @list.include?(n)
    }
  end
end
