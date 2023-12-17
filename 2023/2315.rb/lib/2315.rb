# frozen_string_literal: true

# StringHash
class StringHash
  def initialize(text)
    @parts = text.split(',')
    @h = Hash.new { |h, k| h[k] = {} }
  end

  def self.from_file(filename)
    new(File.read(File.join('data', filename)).strip)
  end

  def hash(str)
    str.chars.inject(0) {|sum, char|
      ((sum + char.ord) * 17) % 256
    }
  end

  def run
    @parts.map{|p| hash(p)}.sum
  end

  def focusing_power
    @parts.each_with_index{|pt, i|
      label = pt.match(/\w+/)[0]
      box = hash(label)
      if pt.match('-')
        @h[box].delete(label)
      else
        old_value = @h[box][label]
        new_value = pt.match(/\d+/)[0].to_i
        if old_value.nil?
          @h[box][label] = [i, new_value]
        else
          old_index, = old_value
          @h[box][label] = [old_index, new_value]
        end
      end
    }

    @h.keys.map{|box|
      @h[box].values.sort.map{|_, v| v}
             .each_with_index.map{|v, index|
               (box + 1) * (index + 1) * v
             }.sum
    }.sum
  end
end
