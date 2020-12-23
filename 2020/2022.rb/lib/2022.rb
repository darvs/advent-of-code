# frozen_string_literal: true

# Crab Cups
class CrabCombat
  def initialize(list)
    @players = Hash.new{|k, v| k[v] = []}
    parse(list)
    puts "players #{@players}"
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def parse(list)
    until list.empty?
      m = /Player (?<num>\d+):/.match(list.first)
      puts "list.first #{list.first} m #{m.named_captures}"
      player_num = m.named_captures['num'].to_i
      puts "player_num #{player_num}"
      list.slice!(0)

      until list.empty? || list.first.empty?
        @players[player_num] = @players[player_num] << list.first.to_i
        list.slice!(0)
      end

      list.slice!(0)
    end
  end

  def play
    until @players[1].empty? || @players[2].empty?
      if @players[1].first > @players[2].first
        @players[1].append(@players[1].first)
        @players[1].append(@players[2].first)
      else
        @players[2].append(@players[2].first)
        @players[2].append(@players[1].first)
      end
      @players[2].slice!(0)
      @players[1].slice!(0)

      puts "players #{@players}"
    end
  end

  def winning
    play
    puts "players #{@players}"
    winner = @players[2].empty? ? @players[1] : @players[2]
    winner.reverse.map.with_index{|val, index| val * (index + 1)}.reduce(&:+)
  end
end
