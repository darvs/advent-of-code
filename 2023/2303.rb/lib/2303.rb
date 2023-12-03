# frozen_string_literal: true

# Schematic
class Schematic
  def initialize(lines)
    @lines = lines

    @symbols = []
    scan_symbols

    @parts = []
    scan_parts

    # puts "symbols #{@symbols}"
    # puts "parts #{@parts}"
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def scan_symbols
    @lines.each.with_index { |l, line_num|
      l.chars.map.with_index.reject { |sym, _|
        [('0'..'9').to_a, '.'].flatten.include?(sym)
      }.each { |sym, pos| @symbols += [[line_num, pos, sym]] }
    }
  end

  # To get every MatchData from multiple matches on the same string
  # we convert scan calls to an Enumerable:
  #
  # https://stackoverflow.com/questions/6804557/how-do-i-get-the-match-data-for-all-occurrences-of-a-ruby-regular-expression-in
  #
  def scan_parts
    @lines.each.with_index { |l, line_num|
      l.to_enum(:scan, /\d+/).map {
        m = Regexp.last_match
        @parts += [[line_num, m.offset(0)[0], m[0]]]
      }
    }
  end

  def filter_parts_with_nearby_symbol_in_list(symbol_list)
    @parts.filter { |px, py, part|
      symbol_list.any? { |sx, sy, _|
        sx.between?(px - 1, px + 1) and sy.between?(py - 1, py + part.length)
      }
    }
  end

  def sum_of_part_numbers
    filtered = filter_parts_with_nearby_symbol_in_list(@symbols)
    filtered.map { |_, _, part| part.to_i }.sum
  end

  def filter_gears_with_two_nearby_parts
    @symbols.map { |sym| filter_parts_with_nearby_symbol_in_list([sym]) }
            .filter { |list| list.length == 2 }
  end

  def sum_of_gear_ratios
    filter_gears_with_two_nearby_parts
      .map { |list| list.first[2].to_i * list.last[2].to_i }
      .sum
  end
end
