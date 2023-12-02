# frozen_string_literal: true

# Conundrum of Cubes
class Cubes
  def initialize(lines)
    @hash = {}
    @lines = lines.map { |l| parse(l) }
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def parse(line)
    game, reveals = line.split(':')
    game_num = game.split(' ').last.to_i
    puts "game #{game_num}"

    list = []

    reveals.split(';').each{ |v|
      puts "v #{v}"
      color_hash = Hash.new(0)
      v.split(',').each{ |c|
        num, color = c.split(' ')
        color_hash[color] = num.to_i
      }
      list.append(color_hash)
    }

    @hash[game_num] = list
  end

  def sum
    puts @hash
    @hash.keys.filter { |k|
      @hash[k].all? { |v| v['red'] <= 12 and v['green'] <= 13 and v['blue'] <= 14 }
    }.sum
  end

  def power_sum
    @hash.keys.map { |game|
      max = Hash.new(0)
      @hash[game].each { |reveal|
        reveal.map { |color, v|
          puts "color #{color} v #{v}"
          max[color] = [max[color], v].max
        }
      }
      puts "max #{max}"
      %w[red green blue].map { |c| max[c] }.reduce(&:*)
    }.sum
  end
    
end
