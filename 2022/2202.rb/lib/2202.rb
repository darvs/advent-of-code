# frozen_string_literal: true

# RoShamBo
class RoShamBo
  def initialize(list)
    @list = list
    @rules = {}

    add_rules(:paper, :rock)
    add_rules(:scissors, :paper)
    add_rules(:rock, :scissors)
  end

  # Add a rules where you beat them
  def add_rules(winner, loser)
    @rules[[winner, loser]]  = :lose
    @rules[[loser,  winner]] = :win
    @rules[[winner, winner]] = :draw

    @rules[[winner, :lose]]  = loser
    @rules[[loser,  :win]]   = winner
    @rules[[winner, :draw]]  = winner
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip).map(&:split))
  end

  def score(list, xyz)
    abc = { 'A' => :rock, 'B' => :paper, 'C' => :scissors }
    scores = { rock: 1, paper: 2, scissors: 3,
               win: 6, draw: 3, lose: 0 }
    list.map{|opponent, me| [abc[opponent], xyz[me]] }.map{|a, x| scores[x] + scores[@rules[[a, x]]]}.sum
  end

  def score_part1
    score(@list, { 'X' => :rock, 'Y' => :paper, 'Z' => :scissors })
  end

  def score_part2
    score(@list, { 'X' => :lose, 'Y' => :draw, 'Z' => :win })
  end
end
