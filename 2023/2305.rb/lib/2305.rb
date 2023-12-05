# frozen_string_literal: true

# Fertilizer
class Fertilizer
  def initialize(lines)
    @lines = Array.new(lines)
    @seeds = []
    @ranges = Array.new(parse_lines)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def parse_lines
    ranges = []
    tmp_ranges = []
    @lines.each{|line|
      if line.scan(/seeds/).any?
        @seeds = line.scan(/\d+/).map(&:to_i)
        next
      end

      next if line.empty?

      if line.scan(/map/).any?
        ranges += [tmp_ranges] if tmp_ranges.any?
        tmp_ranges = []
        next
      end

      tmp_ranges += [line.scan(/\d+/).map(&:to_i)]
    }

    # Don't forget ranges of the last map
    ranges += [tmp_ranges] if tmp_ranges.any?

    ranges
  end

  def convert(val, range)
    destination, source, length = range
    return val - source + destination if val.between?(source, source + length - 1)

    nil
  end

  def run(seed)
    val = seed
    @ranges.each{|range_map|
      converted = range_map.map{|range| convert(val, range)}.compact.first
      next if converted.nil?

      val = converted
    }
    val
  end

  def convert_seed_range(seeds)
    converted = []
    seeds.each_slice(2){|start, len|
      converted += [(start..(start + len - 1)).to_a]
    }
    converted.flatten
  end

  def lowest_location(using_seed_ranges)
    @seeds = convert_seed_range(@seeds) if using_seed_ranges

    puts "seeds #{@seeds}"
    # puts "ranges #{@ranges}"
    locations = @seeds.map{|s| run(s)}
    # puts locations
    locations.min
  end
end
