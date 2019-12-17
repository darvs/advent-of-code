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

    #p [:mod, mod]

    list = []
    (0..7).each{|n|
      list += [mod[offset+n]]
    }
    #p [:zelist, list]

    x = apply(mod, rounds-1, list)
    #p [:apply_returned, x]
    x.map(&:to_s).reduce(&:+)
  end

  def digits(n, offset = 0)
    @signal[offset..offset + n - 1].map(&:abs).map{|x| x % 10}.map(&:to_s).reduce(&:+)
  end

  def digits_with_offset(n)
    digits(n, @check_offset)
  end

  def adjust_signs(globsign, list)
    #p [:adjust_signs,globsign,list]
    return list if globsign == :+

    list.map{|sign, val|
      [sign == :+ ? :- : :+, val]
    }
  end

  def apply(mod, round, list)
    #p [:apply, round, list]

    if round == 0
      #p [:zerolist, list]
      ret = (list.map{|sublist|
        #p [:sublist, sublist]
        sublist.map{|sign, n|
          #p [:sign, sign, :n, n]
          sign == :+ ? @signal[n] : -@signal[n]
        }.reduce(:+).abs % 10
      })
      #p [:returns, ret]
      return ret
    end



    #apply(mod, round - 1, list.map{|digits|
      #digits.map{|sign, n|
        #adjust_signs(sign, mod[n])
      #}.flatten(1)}
    #)

    #p [:applylist, list]
    return list.map{|sublist|
      sublist.map{|sign, n|
        a = apply(mod, round - 1, [mod[n]]).first
        #p [:applied,a]
        sign == :+ ? a : -a
      }.reduce(&:+).abs % 10
    }

  end
end
