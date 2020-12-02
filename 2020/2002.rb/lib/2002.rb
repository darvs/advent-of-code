# frozen_string_literal: true

# Expense report
class Passwords
  def initialize(list)
    @list = list.map{|s| parse(s)}
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def parse(string)
    /([[:digit:]]+)-([[:digit:]]+) ([[:alpha:]]): ([[:alpha:]]+).*/
      .match(string)
  end

  def rule1(matches)
    _, lo, hi, ch, passwd = *matches
    passwd.chars.count(ch).between?(lo.to_i, hi.to_i)
  end

  def rule2(matches)
    _, first, second, ch, passwd = *matches
    (passwd[first.to_i - 1] == ch) ^ (passwd[second.to_i - 1] == ch)
  end

  def check(rule)
    @list.select{|matches|
      case rule
      when 1
        rule1(matches)
      when 2
        rule2(matches)
      end
    }.count
  end
end
