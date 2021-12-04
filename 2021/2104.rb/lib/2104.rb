# frozen_string_literal: true

# Binary Diagnostic
class SquidBingo
  attr_accessor :winning_card, :turn, :numbers_drawn

  def initialize(list)
    p @numbers_drawn = list[0].strip.split(',').map(&:to_i)

    @turn = 0
    @winning_turn = 0
    @cards = []
    @all_winning_cards = []
    @winning_card = nil

    @play_to_win = true

    read_cards(list[1..].filter{|x| !x.empty?})

    p @cards
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
    a_winning_card = nil

    (0..(@cards.length - 1)).each{|n|
      unless @all_winning_cards.include? n
        if check_card(n)
          a_winning_card = n
          break if @play_to_win
          @all_winning_cards += [n]
        end
      end
    }

    unless a_winning_card.nil?
      @winning_turn = @turn
      @winning_card = a_winning_card
      p "Winning: turn:#{@winning_turn} winning_card:#{@winning_card}"
      return if @play_to_win
    end

    @turn += 1
    play unless @turn == @numbers_drawn.length
  end

  def check_card(n)
    #p "Check card #{n} turn #{@turn} drawn #{@numbers_drawn[0..@turn]} card #{@cards[n]}"
    @cards[n].any?{|line| line.all?{|num| @numbers_drawn[0..@turn].include? num}} or
      @cards[n].transpose.any?{|column| column.all?{|num| @numbers_drawn[0..@turn].include? num}}
  end

  def unmarked
    @cards[@winning_card].flatten.reject{|num| @numbers_drawn[0..@winning_turn].include? num}.reduce(&:+)
  end

  def formula
    p ["unmarked: #{unmarked} winning_turn #{@winning_turn}"]
    unmarked * @numbers_drawn[@winning_turn]
  end
end
