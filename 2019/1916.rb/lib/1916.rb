# frozen_string_literal: true

# A Class to compute Flawed Frequency Transmission
class FFT
  def initialize(signal, times = 1)
    @signal = (signal * times).chars.map(&:to_i)

    @check_offset = @signal[0..6].map(&:to_s).reduce(:+).to_i

    @memo = Hash.new
  end

  def self.from_file(filename)
    new(File.read(File.join('data', filename)).strip)
  end

  def run(rounds, offset = 0)
    mod = Hash.new([])

    (0..@signal.length - 1).each{|output_index|

      index = output_index
      while index < @signal.length do
        (index..index + output_index).each {|x|
          break if x >= @signal.length

          mod[output_index] += [[:+, x]]
        }
        index += (4 * (output_index + 1))
      end

      index2 = output_index + (2 * (output_index+1))
      while index2 < @signal.length do
        (index2..index2 + output_index).each {|x|
          break if x >= @signal.length

          mod[output_index] += [[:-, x]]
        }
        index2 += (4 * (output_index + 1))
      end
    }

    list = []
    (0..7).each{|n|
      list += [mod[offset+n]]
    }
    #p [:zelist, list.flatten.reject{|x| [:+, :-].include?(x)}.sort.uniq.length]
    #dgdg

    x = apply(mod, rounds-1, list)
    x.map(&:to_s).reduce(&:+)
  end

  def digits(n, offset = 0)
    @signal[offset..offset + n - 1].map(&:abs).map{|x| x % 10}.map(&:to_s).reduce(&:+)
  end

  def digits_with_offset(n)
    digits(n, @check_offset)
  end

  def adjust_signs(globsign, list)
    return list if globsign == :+

    list.map{|sign, val|
      [sign == :+ ? :- : :+, val]
    }
  end

  def apply_memo(mod, round, list)
    #p [:apply_memo,round,list,@memo]
    m = @memo[[round, list]]
    if m.nil?
      @memo[[round, list]] = apply(mod, round, list)
    end
    @memo[[round, list]]
  end

  def apply(mod, round, list)

    if round == 0
      ret = (list.map{|sublist|
        sublist.map{|sign, n|
          sign == :+ ? @signal[n] : -@signal[n]
        }.reduce(:+).abs % 10
      })
      return ret
    end

    return list.map{|sublist|
      sublist.map{|sign, n|
        a = apply_memo(mod, round - 1, [mod[n]]).first
        sign == :+ ? a : -a
      }.reduce(&:+).abs % 10
    }

  end
end
