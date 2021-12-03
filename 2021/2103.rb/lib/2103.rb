# frozen_string_literal: true

# Binary Diagnostic
class BinaryDiagnostic
  def initialize(list)
    @list = list
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip))
  end

  def run_part1
    @list.map(&:chars)
         .transpose
         .map{|x| x.group_by(&:itself).map{|k, v| [k, v.count]}}
         .map{|x| x.sort{|a, b| b[1] <=> a[1]}}
         .map{|x| x.map{|k, _| k[0]}}
         .transpose
         .map{|x| x.reduce(&:concat).to_i(2)}
         .reduce(&:*)
  end

  def run_part2
    part2_nth_bit(@list, true).to_i(2) *
      part2_nth_bit(@list, false).to_i(2)
  end

  def part2_nth_bit(remain, check_most_used, nth_bit = 0)
    return remain[0] if remain.length == 1

    most_used = remain.map(&:chars)
                      .transpose[nth_bit]
                      .group_by(&:itself)
                      .map{|k, v| [k, v.count]}
                      .reduce{|a, b|
                        if b[1] == a[1]
                          '1'
                        elsif b[1] > a[1]
                          b[0]
                        else
                          a[0]
                        end
                      }

    #p ["Remain: #{remain}"]
    #p ["Most Used: #{most_used}"]

    check = if check_most_used
              most_used
            else
              most_used == '0' ? '1' : '0'
            end

    #p ["Check: #{check}"]

    part2_nth_bit(remain.filter{|x| x[nth_bit] == check}, check_most_used, nth_bit + 1)
  end
end
