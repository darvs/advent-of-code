# frozen_string_literal: true

# A Class to compute Flawed Frequency Transmission
class FFT
  def initialize(signal)
    @signal = signal.chars.map(&:to_i)
  end

  def self.from_file(filename)
    new(File.read(File.join('data', filename)).strip)
  end

  def run(rounds)
    (1..rounds).each do
      @signal = (0..@signal.length - 1).map{|output_index|
        out = 0

        # + part
        index = output_index
        while index < @signal.length do
          (0..output_index).each {|x|
            if index + x < @signal.length
              #p [output_index, :+, :index, index + x, :val, @signal[index + x]]
              out += @signal[index + x]
            end
          }
          index += (4 * (output_index + 1))
        end

        index2 = output_index + (2 * (output_index+1))
        while index2 < @signal.length do
          (0..output_index).each {|x|
            if index2 + x < @signal.length
              #p [output_index, :-, :index2, index2 + x, :val, @signal[index2 + x]]
              out -= @signal[index2 + x]
            end
          }
          index2 += (4 * (output_index + 1))
        end

        out.abs % 10
      }
    end
  end

  def pattern_digit_multiplier(input_pos, output_pos)
    [0, 1, 0, -1][((input_pos + 1) / (output_pos + 1)) % 4]
  end

  def digits(n)
    @signal[0..n - 1].map(&:to_s).reduce(&:+)
  end
end
