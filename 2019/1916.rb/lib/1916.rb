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
        @signal.each_with_index.map{|digit, input_index|
          digit * pattern_digit_multiplier(input_index, output_index)
        }.reduce(&:+).abs % 10
      }
    end
  end

  def pattern_digit_multiplier(input_pos, output_pos)
    base = [0, 1, 0, -1]
    offset = ((input_pos + 1) / (output_pos + 1)) % base.length
    base[offset]
  end

  def digits(n)
    @signal[0..n - 1].map(&:to_s).reduce(&:+)
  end
end
