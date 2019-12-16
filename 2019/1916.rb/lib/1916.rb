# frozen_string_literal: true

# A Class to compute Flawed Frequency Transmission
class FFT
  def initialize(signal, times = 1)
    @signal = (signal * times).chars.map(&:to_i)

    @check_offset = @signal[0..6].map(&:to_s).reduce(:+).to_i
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
          (index..index + output_index).each {|x|
            break if x >= @signal.length

            out += @signal[x]
          }
          index += (4 * (output_index + 1))
        end

        index2 = output_index + (2 * (output_index+1))
        while index2 < @signal.length do
          (index2..index2 + output_index).each {|x|
            break if x >= @signal.length

            out -= @signal[x]
          }
          index2 += (4 * (output_index + 1))
        end

        out.abs % 10
      }
    end
  end

  def digits(n, offset = 0)
    @signal[offset..offset + n - 1].map(&:to_s).reduce(&:+)
  end

  def digits_with_offset(n)
    digits(n, @check_offset)
  end
end
