# frozen_string_literal: true

# Handbags
class Handbags
  def initialize(list)
    @hash = Hash.new([])
    parse(list)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def capture_bag(descr)
    /(?<qty>\d+)?\s?(?<adjective>\w+) (?<color>\w+) bag/.match(descr)
  end

  def parse(list)
    list.each{|line|
      #puts "parsing:: #{line}"
      container, content = line.split('contain')

      container_data = capture_bag(container).named_captures

      content.split(',').each{|contained|
        contained_data = capture_bag(contained).named_captures

        @hash[container_data] += [contained_data]
      }
    }
    @hash.keys.each{|k|
      puts "H[#{k} :: #{@hash[k]}"
    }
    puts "-------------------------------------------"
  end

  def contain
    #puts (@hash.keys)
    #puts (@hash.keys).select{|h| h['adjective'] == 'shiny' && h['color'] == 'gold'}
    @set = Set.new
    count('shiny', 'gold')
    puts "Set: #{@set}"
    @set.size
  end

  def count(adj, col)
    puts "COUNT:: #{adj},#{col}"
    return if adj == 'no'

    @hash.each{|k, v|
      v.each{|bag|
        if bag['adjective'] == adj && bag['color'] == col
          puts "bag:: #{bag} || key:: #{k}"
          if @set.add?("#{k['adjective']} #{k['color']}")
            count(k['adjective'], k['color'])
          end
        end
      }
    }
  end

end
