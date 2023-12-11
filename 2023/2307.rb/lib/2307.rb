# frozen_string_literal: true

# Hand: a set of cards and a bid
class Hand
  attr_reader :type, :val, :bid

  ALL_TYPES = [
    [1, 1, 1, 1, 1],  # High card
    [2, 1, 1, 1],     # One pair
    [2, 2, 1],        # Two pairs
    [3, 1, 1],        # Three of a kind
    [3, 2],           # Full house
    [4, 1],           # Four of a kind
    [5]               # Five of a kind
  ].freeze

  ALL_VALS = '..23456789TJQKA'

  def initialize(line)
    hand_str, bid_str = line.split(' ')
    @bid  = bid_str.to_i
    @hand = parse_hand(hand_str)
    @type = parse_type
    @val  = parse_value
  end

  def parse_hand(hand_str)
    hand_str.chars.map{|c|
      self.class::ALL_VALS.index(c)
    }
  end

  def parse_type
    self.class::ALL_TYPES.index(@hand.tally.sort_by{|_, v| v}.reverse.to_h.map{|_, v| v})
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

# Hand for part 2 of the Day
class SecondHand < Hand
  ALL_VALS = '.J23456789T.QKA'

  def parse_type
    jokes, no_jokes = @hand.partition{|card| card == ALL_VALS.index('J')}
    return self.class::ALL_TYPES.index([5]) if no_jokes.empty? # All Jokers

    tally_qty = no_jokes.tally.sort_by{|_, v| v}.reverse.to_h.map{|_, v| v}
    #puts "parse hand #{@hand} nb_jokes #{jokes.count} no_jokes #{no_jokes} tally_qty #{tally_qty}"
    tally_with_jokes = [tally_qty.first + jokes.count] + tally_qty[1..]
    self.class::ALL_TYPES.index(tally_with_jokes)
  end
end

# Cards
class Cards
  def initialize(lines)
    @lines = Array.new(lines)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def winnings(jokers_are_wild)
    hands = @lines.map{|l| jokers_are_wild ? SecondHand.new(l) : Hand.new(l)}.to_a
    hands.sort.map(&:bid).zip((1..(hands.length))).map{|v, rank| v * rank}.sum
  end
end
