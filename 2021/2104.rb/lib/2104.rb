# frozen_string_literal: true

# Binary Diagnostic
class SquidGame
  attr_accessor :winning_card, :last_winning_turn, :numbers_drawn

  def initialize(list)
    @numbers_drawn = list[0].strip.split(',').map(&:to_i)

    @cards = []
    @last_winning_turn = nil
    @winning_cards = []

    @play_to_win = true

    read_cards(list[1..].filter{|x| !x.empty?})
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip))
  end

  def read_cards(list)
    current = []

    (0..4).each {|n|
      current += [list[n].strip.split(' ').map(&:to_i)]
    }

    @cards += [current]

    read_cards(list[5..]) if list.length > 5
  end

  def play_to_lose
    @play_to_win = false
    play
  end

  def play
    (0..(@numbers_drawn.length - 1)).each{|turn|
      @cards.each_with_index{|card, card_index|
        next if @winning_cards.include? card_index

        next unless check_card(card, @numbers_drawn[0..turn])

        #p "Winning card #{n} at turn #{turn} play to win? #{@play_to_win}"
        @winning_cards += [card_index]
        @last_winning_turn = turn
        break if @play_to_win
      }

      break if @play_to_win && (@last_winning_turn == turn)
    }
  end

  def check_card(card, numbers)
    #p "Check card #{n} turn #{@turn} drawn #{@numbers_drawn[0..@turn]} card #{@cards[n]}"
    card.any?{|line| line.all?{|mine| numbers.include? mine}} or
      card.transpose.any?{|column| column.all?{|mine| numbers.include? mine}}
  end

  def unmarked
    #p ["unmarked card #{@winning_cards[-1]} turn #{@last_winning_turn}"]
    @cards[@winning_cards[-1]].flatten.reject{|num| @numbers_drawn[0..@last_winning_turn].include? num}.reduce(&:+)
  end

  def formula
    #p ["unmarked: #{unmarked} winning_turn #{@last_winning_turn}"]
    unmarked * @numbers_drawn[@last_winning_turn]
  end
end
