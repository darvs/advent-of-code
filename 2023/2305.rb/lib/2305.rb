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
      puts "seed-range #{start}-#{start + len - 1}"

      converted += [(start..(start + len - 1)).to_a]
    }
    converted.flatten
  end

  def convert_range_level(level)
    @ranges[level].map{|dest, source, len|
      # dest, source, len = r
      [[source, source + len - 1], dest]
    }
  end

  def lowest_location(using_seed_ranges)
    if using_seed_ranges
      lowest_location_using_seed_ranges
    else
      #@seeds = convert_seed_range(@seeds) if using_seed_ranges

      #convert_ranges if using_seed_ranges

      puts "seeds #{@seeds}"
      puts "ranges #{@ranges}"

      locations = @seeds.map{|s| run(s)}
      # puts locations
      locations.min
    end
  end

  def split_range_sub(to_split, llist, next_level_ranges = [])
    # We've processed the whole range
    return [next_level_ranges] if to_split.empty?

    # There are no more rules to try
    return [next_level_ranges] + [to_split] if llist.empty?

    ts_a, ts_z = to_split.head
    ll_a, ll_z = llist.head.head

    # No intersection
    return split_range_sub(to_split, llist.tail, next_level_ranges) if (ts_z < ll_a) || (ts_a > ll_z)

    # to_split is wholly inside ll
    return split_range_sub(to_split.tail, llist, [next_level_ranges] + [to_split.head]) if (ts_z >= ll_a) && (ts_z <= ll_z)


  end

  def split_range(to_split)
    # The end
    #return next_level_ranges if level == @ranges.length

    # Level up
    #return split_range(next_level_ranges, level+1, [])

    #ranges = @ranges[level]

    (0..0).each{|level|
      range_level = convert_range_level(level)
      puts "range_level #{range_level}"
      rez = split_range_sub(to_split, range_level, [])
      puts "rez #{rez}"
    }
  end

  def lowest_location_using_seed_ranges
    seed_ranges = []
    @seeds.each_slice(2){|start, len|
      seed_ranges += [[start, start + len - 1]]
    }

    puts "seed_ranges #{seed_ranges}"

    split_range(seed_ranges)

    # convert_ranges
  end
end
