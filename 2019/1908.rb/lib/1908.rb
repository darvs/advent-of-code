# frozen_string_literal: true

# A Space Image Format image
class Image
  def initialize(arr, width, height)
    @width = width
    @height = height
    @layers = arr.each_slice(width * height).reduce([]){|layers, x|
      layers + [x]
    }
  end

  def self.from_file(filename, width, height)
    Image.new(File.read(File.join('data', filename)).strip.chars.map(&:to_i),
              width,
              height)
  end

  def layer_with_least_first_multiply_second_third(first, second, third)
    @layers.map{|l|
      l.each_with_object(Hash.new(0)){|color, hash|
        hash[color] += 1
      }
    }
           .min_by{|l| l[first]}
           .select{|k, _| [second, third].include?(k)}
           .map{|_, v| v}
           .reduce(&:*)
  end

  def show
    @layers.transpose.map{|px|
      px.reduce('.'){|color, pixel|
        case pixel
        when 1 then break '#'
        when 0 then break ' '
        else color
        end
      }
    }.each_slice(@width).reduce([]){|line, px|
      line + [px]
    }.map(&:join).each{|l| puts(l)}
  end
end
