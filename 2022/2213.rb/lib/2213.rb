# frozen_string_literal: true

# Annoying List
class DistressSignal
  def initialize(list)
    @list = list.each_slice(2).map{|a, b|
      [a, b].map{|i| parse_packet(i)}
    }
    p @list
  end

  def parse_packet(s)
    l = s.chars
         .reject{|c| c == ','}
         .map{|c| ['[', ']'].include?(c) ? c : c.to_i}
         .drop(1)

    #puts "l #{l}"

    parsed = parse_list(l.clone)
    puts "parsed #{parsed}"

    l
  end

  def parse_list(tokens, list=[])
    #puts "p_l #{tokens} | #{list}"
    return list if tokens.empty?

    until tokens.empty?
      head = tokens.first
      tokens.shift(1)

      if head == '['
        list.append(parse_list(tokens))
      elsif head == ']'
        #puts "dumping #{list}"
        return list
      else
        list.append(head)
      end
    end

    list
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:chomp).reject(&:empty?))
  end

  def run
    23
  end
end
