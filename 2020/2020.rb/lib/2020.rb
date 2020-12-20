# frozen_string_literal: true

# Jurassic Puzzle
class Puzzle
  def initialize(lines)
    @tiles = {}
    @edges = {}
    @flipped = {}
    @merged = Hash.new{ |h, k| h[k] = Hash.new(0) }
    parse(lines)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def parse(lines)
    #puts lines.to_s
    until lines.empty? || lines.first.empty?
      m = /\ATile (?<tile>\d+):\Z/.match(lines.first)
      tile = m[:tile]
      lines.slice!(0)

      picture = []

      until lines.empty? || lines.first.empty?
        picture += [lines.first]
        lines.slice!(0)
      end

      lines.slice!(0)

      @tiles[tile] = picture
    end

    #puts @tiles

    @tiles.each{|id, data|
      top = encode(data[0].chars)
      right = encode(data.map{|line| line[-1]})
      bottom = encode(data[9].chars.reverse)
      left = encode(data.map{|line| line[0]}.reverse)

      @edges[id] = [top, right, bottom, left].map{|v| v.to_i(2)}
      @flipped[id] = [top, left, bottom, right].map{|v| v.reverse.to_i(2)}

      @merged[id][0] = @edges[id]
      @merged[id][1] = @flipped[id]
    }

    puts "count edges #{@edges.keys.length} #flipped #{@flipped.keys.length}"

    #puts "edges #{@edges}"
    #puts "flipped #{@flipped}"

    #puts "merged #{@merged}"
    #puts @merged.values.map{|hash| hash.values.flatten}

    [@edges, @flipped].each{|s|
      occ = s.values.flatten.each_with_object(Hash.new(0)){|v, hash| hash[v] += 1}
      puts "occ #{occ}"
      occocc = occ.values.each_with_object(Hash.new(0)){|v, hash| hash[v] += 1}
      puts "occocc #{occocc}"
    }


  end

  def encode(chars)
    chars.map{|c| c == '#' ? '1' : '0'}.join
      #.tap{|encoded| puts "chars #{chars} encoded #{encoded}"}
  end

  def multiply
    mocc = @merged.values.map{|hash| hash.values.flatten}.flatten.each_with_object(Hash.new(0)){|v, hash| hash[v] += 1}
    puts "mocc #{mocc}"
    moccocc = mocc.values.each_with_object(Hash.new(0)){|v, hash| hash[v] += 1}
    puts "moccocc #{moccocc}"

    @merged.each.with_object(Hash.new{|k,v| k[v]=Hash.new(0)}){|(k, v), h|
      v.each{|k2, v2|
        puts "id #{k} [#{k2}] #{v2}"
        h[k][k2] = v2.map{|v3| mocc[v3] == 1 ? v3 : nil}.to_a.tap{|x| puts "X #{x}"}
        puts "H #{h}"
      }
      puts "hash: #{h}"
    }.tap{|rez| puts "rez: #{rez}"}

    0
  end

  def multiply0
    return 0
    
    #puts "mult edges #{@edges}"
    #puts "mult flipped #{@flipped}"

    perm = [false, true].repeated_permutation(@edges.length).to_a
                        .map{|flipped_array|
                          flipped_array.map.with_index.with_object(Hash.new(0)){|(flipped, index), hash|
                            hash[@tiles.keys[index]] = flipped ? @flipped[@tiles.keys[index]] : @edges[@tiles.keys[index]]
                          }
                        }#.tap{puts "perm #{_1}"}

    #perm.select{|p|
      #occ = p.values.flatten.each_with_object(Hash.new(0)){|v, hash| hash[v] += 1}#.values.each_with_object(Hash.new(0)){|v, hash| hash[v] += 1}
      #puts "p #{p}"
      #puts "occ #{occ}"
      ##p.map{|tile, _| puts "tile #{tile}"}
      #occ.select{|_, v| v == 1}.keys.length == Math.sqrt(@edges.length) * 4
    #}.tap{|s| puts "selected #{s}"}

    perm.map{|p|
      occ = p.values.flatten.each_with_object(Hash.new(0)){|v, hash| hash[v] += 1}
      #puts "p #{p}"
      #puts "occ #{occ}"
      #occ.select{|_, v| v == 1}.keys.length == Math.sqrt(@edges.length) * 4
      p.each_with_object(Hash.new(0)){|(k, v), hash|
        hash[k] = v.map{|x| occ[x]}
      }
    }.select{|comb|
      #puts "comb #{comb.values.flatten.select{|occ| occ == 1}.length}"
      comb.values.flatten.select{|occ| occ == 1}.length == Math.sqrt(@edges.length) * 4
    }.map{|comb|
      comb.select{|_, l| l.select{|v| v == 1}.length == 2}.keys.sort
    }.uniq.flatten.tap{|s| puts "selected #{s}"}#.reduce(&:*)

  end
end
