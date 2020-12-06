# frozen_string_literal: true

# CustomDeclarations
class CustomDeclarations
  def initialize(list)
    @list = parse(list)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def parse(list)
    sub = []
    chopped = []
    list.each{|line|
      if line.empty?
        chopped += [sub]
        sub = []
      else
        sub += [line]
      end
    }
    chopped += [sub]
  end

  def total
    @list.map{|group|
      group.map(&:chars).reduce(&:+).uniq.count
    }.sum
  end

  def allyes
    @list.map{|group|
      [group.size,
       group.map(&:chars).join.chars.each_with_object(Hash.new(0)){|answer, cnt|
         cnt[answer] += 1
         cnt
       }]
    }.map{|size, hash|
      hash.values.select{|v| v == size}.count
    }.sum
  end
end
