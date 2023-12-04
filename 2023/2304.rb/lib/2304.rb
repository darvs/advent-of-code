# frozen_string_literal: true

# Scratchcards
class Scratchcards
  def initialize(lines)
    @lines = lines
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def scan_line(line)
    header, cards = line.split(':')
    card_num = header.scan(/\d+/)[0].to_i
    winning, have = cards.split('|').map { |str| str.scan(/\d+/).map(&:to_i).to_set }
    [card_num, winning, have]
  end

  def number_of_matches(scanned_line)
    _, winning, have = scanned_line
    (winning & have).length
  end

  def score_line(scanned_line)
    wins = number_of_matches(scanned_line)
    return 0 if wins.zero?

    2**(wins - 1)
  end

  def total_worth
    @lines.map { |line| scan_line(line) }
          .map { |scanned| score_line(scanned) }
          .sum
  end

  def number_of_cards
    number_of_matches = @lines.map { |line| scan_line(line) }.map { |scanned| number_of_matches(scanned) }
    number_of_cards = number_of_matches.length
    copies = Array.new(number_of_cards, 1)

    number_of_matches.map.with_index { |matches, i|
      (1..matches).map { |n| n + i }.select { |n| n < number_of_cards }
        .each { |n| copies[n] += copies[i] }
    }

    copies.sum
  end
end
