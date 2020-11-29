# frozen_string_literal: true

# A Class to compute Flawed Frequency Transmission
class FFT
  def initialize(signal, times = 1)
    @signal = (signal * times).chars.map(&:to_i)

    @check_offset = @signal[0..6].map(&:to_s).reduce(:+).to_i
    @calc_hash = Hash.new
  end

  def self.from_file(filename)
    new(File.read(File.join('data', filename)).strip)
  end

  def run(rounds)
    mod = Hash.new([])

    (0..@signal.length - 1).each{|output_index|
      index = output_index
      while index < @signal.length
        (index..index + output_index).each {|x|
          break if x >= @signal.length

          mod[output_index] += [[:+, x]]
        }
        index += (4 * (output_index + 1))
      end

      index2 = output_index + (2 * (output_index + 1))
      while index2 < @signal.length
        (index2..index2 + output_index).each {|x|
          break if x >= @signal.length

          mod[output_index] += [[:-, x]]
        }
        index2 += (4 * (output_index + 1))
      end
    }

    #mod.keys.each{|k| p [:mod, k, mod[k]]}

    @new_signal = Hash.new(0)
    (0..0).each{|x|
      @new_signal[x] = calc(mod, x, rounds)
    }

     #(1..rounds).each{|round|
      #@new_signal = Hash.new(0)
      #mod.each{|output_index, l|
        #@new_signal[output_index] = l.map{|sign, x|
          #val = @signal[x]
          #sign == :+ ? val : -val
        #}.reduce(&:+).abs % 10
      #}

      #@signal = @new_signal #.map{|x| x.abs % 10}
    #}

    #p [:new_signal, @new_signal]

    @signal = @new_signal
  end


  def calc(mod, x, phase)
    return @signal[x] if phase.zero?

    return @calc_hash[[x, phase]] if @calc_hash.key?([x, phase])

    @calc_hash[[x, phase]] = mod[x].map{|sign, y|
      val = calc(mod, y, phase - 1)
      val *= -1 if sign == :-
      val
    }.reduce(&:+).abs % 10
  end

  def digits(n, offset = 0)
    (offset..offset + n - 1).map{|x| @signal[x]}.map(&:abs).map{|x| x % 10}.map(&:to_s).reduce(&:+)
  end

  def digits_with_offset(n)
    digits(n, @check_offset)
  end
end
