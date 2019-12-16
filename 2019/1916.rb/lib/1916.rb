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

    #mod.keys.each{|k|
      #p [k,'==',mod[k].map{|_,v| v}]
    #}

    (1..rounds).each do
      @new_signal = Array.new(@signal.length, 0)
      mod.each{|output_index, l|
        
        @new_signal[output_index] = l.map{|sign,x|
          val = @signal[x]
          #mod[output_index].delete_if{|_, v| v[1]==x} if val == 0
          if sign == :+ then val else -val end }.reduce(&:+).abs % 10
      }

      #mod.each{|k, v|
        #v.each{|s, x|
          #p [k,x,@new_signal[x]]
        #}
      #}
 
      #mod.each{|k, v|
        #mod.delete(k) if v.all?{|_, val| val == 0}
      #}

      #mod.each{|k, v|
        #mod[k] = v.select{|_,val| val != 0}
      #}

    #p [:mod, mod]

      @signal = @new_signal #.map{|x| x.abs % 10}
      #p digits(8)
    end

  end

  def digits(n, offset = 0)
    @signal[offset..offset + n - 1].map(&:abs).map{|x| x % 10}.map(&:to_s).reduce(&:+)
  end

  def digits_with_offset(n)
    digits(n, @check_offset)
end
end
