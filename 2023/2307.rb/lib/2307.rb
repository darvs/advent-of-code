# frozen_string_literal: true

# Hand: a set of cards and a bid
class Hand
  attr_reader :type, :val, :bid

  def initialize(line)
    hand_str, bid_str = line.split(' ')
    @bid  = bid_str.to_i
    @hand = parse_hand(hand_str)
    @type = parse_type
    @val  = parse_value
  end

  def parse_hand(hand_str)
    all_vals = '..23456789TJQKA'
    hand_str.chars.map{|c|
      all_vals.index(c)
    }
  end

  def parse_type
    all_types = [
      [1, 1, 1, 1, 1],  # High card
      [2, 1, 1, 1],     # One pair
      [2, 2, 1],        # Two pairs
      [3, 1, 1],        # Three of a kind
      [3, 2],           # Full house
      [4, 1],           # Four of a kind
      [5]               # Five of a kind
    ]
    all_types.index(@hand.tally.sort_by{|_, v| v}.reverse.to_h.map{|_, v| v}) 
  end

  def parse_value
    @hand.inject(0){|total, v|
      (14 * total) + v
    }
  end

  def inspect
    "<hand #{@hand}, type #{@type} val #{@val} bid #{@bid}>"
  end

  def <=>(other)
    ufo = type <=> other.type
    return (val <=> other.val) if ufo.zero?

    ufo
  end
end

# Cards
class Cards
  def initialize(lines)
    @hands = lines.map{|l| Hand.new(l)}.to_a
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def winnings
    #@hands.each{|h| p h}

    @hands.sort.map(&:bid).zip((1..(@hands.length))).map{|v, rank| v*rank}.sum
  end
end
