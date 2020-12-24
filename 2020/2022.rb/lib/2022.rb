# frozen_string_literal: true

# Crab Cups
class CrabCombat
  def initialize(list)
    @players = Hash.new{|k, v| k[v] = []}
    parse(list)
    puts "players #{@players}"
    @done = false
    @breakpoint = 5
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

  def play(p1, p2)
    until p1.empty? || p2.empty?
      c1 = p1.slice!(0)
      c2 = p2.slice!(0)
      if c1 > c2
        p1.append(c1).append(c2)
      else
        p2.append(c2).append(c1)
      end
    end
    p2.empty?
  end

  def winning
    winner = play(@players[1], @players[2]) ? @players[1] : @players[2]
    winner
      .reverse.map.with_index{|val, index|
        val * (index + 1)
      }.reduce(&:+)
  end
end

# CrabCombat, but Recursive
class RecursiveCombat < CrabCombat
  def serialize(p1, p2)
    p1.join(',') + '____' + p2.join(',')
  end

  def play(p1, p2)
    #@breakpoint -= 1
    #throw hands if @breakpoint.zero?

    #puts ">>> reccbt #{p1} #{p2}"
    dejavu = Set.new

    until p1.empty? || p2.empty?
      #puts "reccbt #{p1} #{p2}"

      #puts "dejavu #{dejavu}"
      if dejavu.add?(serialize(p1, p2)).nil?
        #puts "FTS!"
        return true
      end

      c1 = p1.slice!(0)
      c2 = p2.slice!(0)
      #puts "reccbt #{c1} #{c2} | p1l #{p1.length} p2l #{p2.length}"

      cond = p1.length < c1 || p2.length < c2 ? c1 > c2 : play(p1.slice(0, c1), p2.slice(0, c2))

      if cond
        p1.append(c1).append(c2)
      else
        p2.append(c2).append(c1)
      end
    end
    p2.empty?
  end
end
