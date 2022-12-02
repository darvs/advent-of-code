# frozen_string_literal: true

# RoShamBo
class RoShamBo
  @@victory = 6
  @@draw = 3
  @@defeat = 0

  def initialize(list)
    @list = list
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip).map(&:split))
  end

  def round(picks)
    shapes = { :rock => 1, :paper => 2, :scissors => 3 }

    shapes[picks[1]] + case picks
    when [:rock, :paper] then @@victory
    when [:rock, :scissors] then @@defeat
    when [:paper, :scissors] then @@victory
    when [:paper, :rock] then @@defeat
    when [:scissors, :rock] then @@victory
    when [:scissors, :paper] then @@defeat
    else @@draw
    end
  end

  def score(list, table)
    #p table
    list.map{|opponent, me| [table[opponent], table[me]] }.map{|picks| round(picks)}.sum
    
  end

  def score_part1
    #p @list

    score(@list, { 'A' => :rock, 'B' => :paper, 'C' => :scissors,
                   'X' => :rock, 'Y' => :paper, 'Z' => :scissors })
  end
end
