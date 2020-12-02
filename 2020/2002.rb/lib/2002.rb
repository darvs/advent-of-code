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
    matches = /([[:digit:]]+)-([[:digit:]]+) ([[:alpha:]]): ([[:alpha:]]+)/
              .match(string)
    [matches[1].to_i, matches[2].to_i, matches[3], matches[4]]
  end

  def rule1(lo, hi, ch, passwd)
    passwd.chars.count(ch).between?(lo, hi)
  end

  def rule2(first, second, ch, passwd)
    (passwd[first - 1] == ch) ^ (passwd[second - 1] == ch)
  end

  def check(rule)
    @list.select{|matches|
      self.method([:rule1, :rule2][rule - 1]).call(*matches)
    }.count
  end
end
