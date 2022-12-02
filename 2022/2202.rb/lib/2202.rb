# frozen_string_literal: true

# RoShamBo
class RoShamBo
  @@victory = 6
  @@draw = 3
  @@defeat = 0
  @@scores = { :rock => 1, :paper => 2, :scissors => 3,
               :win => 6, :draw => 3, :lose => 0 }

  def initialize(list)
    @list = list
    @rules = Set.new

    add_rules(:paper, :rock)
    add_rules(:scissors, :paper)
    add_rules(:rock, :scissors)

    p @rules
  end

  # Add a rules where you beat them
  def add_rules(winner, loser)
    @rules.add([winner, loser, :lose])
    @rules.add([loser, winner, :win])
    @rules.add([winner, winner, :draw])
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip).map(&:split))
  end

  def score(list, lookup, table)
    #p table

    list.map{|opponent, me| [table[opponent], table[me]] }.map{|picks| @@scores[picks[1]] + @@scores[lookup[picks]]}.sum
    
  end

  def score_part1
    #p @list

    lookup = {}
    @rules.each{|a, x, w| lookup[[a, x]] = w}

    puts "lookup #{lookup}"

    score(@list, lookup, { 'A' => :rock, 'B' => :paper, 'C' => :scissors,
                           'X' => :rock, 'Y' => :paper, 'Z' => :scissors })
  end

  def score_part2
    #p @list

    lookup = {}
    @rules.each{|a, x, w| lookup[[a, w]] = x}

    puts "lookup #{lookup}"

    score(@list, lookup, { 'A' => :rock, 'B' => :paper, 'C' => :scissors,
                           'X' => :lose, 'Y' => :draw, 'Z' => :win })
  end
end
