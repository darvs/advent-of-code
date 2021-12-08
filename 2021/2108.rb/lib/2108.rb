# frozen_string_literal: true

# ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn
class Abba
  def initialize(input)
    @list = input
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip).map{|line|
      line.split('|').map(&:strip).map{|part| part.split.map{|word| word.chars.sort.reduce(&:+)}}
    })
  end

  # digit : number of segments
  # 0 : 6
  # 1 : 2
  # 2 : 5
  # 3 : 5
  # 4 : 4
  # 5 : 5
  # 6 : 6
  # 7 : 3
  # 8 : 7
  # 9 : 6

  def run
    # Digits 1,4,7,8 have 2,4,3,7 segments respectively
    @list.map{|line| line[1]}.flatten.map(&:length).filter{|len| [2, 4, 3, 7].include?(len)}.count
  end

  def decode
    @list.map{|line|
      @arr = Array.new(10)
      @hash = Hash.new(0)

      @words = line.flatten.uniq
      @words.each{|w| @hash[w] = nil}

      solve_by_len
      solve_zero_vs_six_vs_nine
      solve_two_vs_three_vs_five

      #p "words :: #{@words}"
      #p "hash :: #{@hash}"
      #p "array :: #{@arr}"

      #p @arr.each_with_index.map{|segment, i| segment.nil? ? '.' : i.to_s}.reduce(&:+)

      #p "line #{line}"

      line[1].map{|word| @hash[word].to_s}.reduce(&:+).to_i
    }.sum
  end

  def solve_by_len
    @words.each{|w|
      case w.length
      when 2
        solved(1, w)
      when 4
        solved(4, w)
      when 3
        solved(7, w)
      when 7
        solved(8, w)
      end
    }
  end

  # 0 and 6 and 9 have the same number of segments
  # But only 9 has all the segments from 4
  # And all the segments from 1 are in 0
  def solve_zero_vs_six_vs_nine
    return if @arr[1].nil? || @arr[4].nil?

    #p "1,4: #{@arr[1]},#{@arr[4]}"

    @words.filter{|x| x.length == 6 && @hash[x].nil?}.each{|w|
      if @arr[4].chars.all?{|c| w.chars.include?(c)}
        solved(9, w)
      elsif @arr[1].chars.all?{|c2| w.chars.include?(c2)}
        solved(0, w)
      else
        solved(6, w)
      end
    }
  end

  # For the digits with 5 segments,
  # If it contains all the segments from 1, it's a 3
  # Else if all its segments are contained in a 6,
  # Then it's a 5, otherwise it's a 2.
  def solve_two_vs_three_vs_five
    return if @arr[1].nil? || @arr[6].nil?

    #p "1,6: #{@arr[1]},#{@arr[6]}"

    @words.filter{|x| x.length == 5 && @hash[x].nil?}.each{|w|
      if @arr[1].chars.all?{|c| w.chars.include?(c)}
        solved(3, w)
      elsif w.chars.all?{|c2| @arr[6].chars.include?(c2)}
        solved(5, w)
      else
        solved(2, w)
      end
    }
  end

  def solved(num, word)
    @arr[num] = word
    @hash[word] = num
  end
end
