# frozen_string_literal: true

# Annoying List
class DistressSignal
  def initialize(list)
    @list = list.each_slice(2).map{|a, b|
      [a, b].map{|string|
        eval(string)
        #parse_packet(string)
      }
    }
    #p @list
  end

  def parse_packet(string)
    l = string.chars.drop(1)

    #puts "l #{l}"

    parsed = parse_list(l.clone)
    puts "parsed #{parsed}"

    parsed
  end

  def parse_list(tokens, list = [])
    until tokens.empty?
      head = tokens.shift

      case head
      when '['
        list.append(parse_list(tokens))
      when ']'
        return list
      when ','
        # do no thing
      else
        n = ''
        while '0123456789'.index(head)
          n += head
          head = tokens.shift
        end
        list.append(n.to_i)
      end
    end

    list
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:chomp).reject(&:empty?))
  end

  # def cmp(left, right)
  #   puts "cmp #{left} and #{right}"
  #
  #   return left < right if left.is_a?(Integer) && right.is_a?(Integer)
  #
  #   return cmp([left], right) if left.is_a?(Integer) && right.is_a?(Array)
  #
  #   return cmp(left, [right]) if left.is_a?(Array) && right.is_a?(Integer)
  #
  #   return true if left.empty?
  #
  #   return false if right.empty?
  #
  #   l = left.shift
  #   r = right.shift
  #
  #   puts "checkints #{l} #{r}"
  #   return false if !cmp(l, r)
  #   puts "reroll #{left} #{right}"
  #
  #   cmp(left, right)
  # end
  #

  def check_type(var)
    var.is_a?(Integer) ? :int : :arr
  end

  # cmp
  # -----
  # left & right are lists
  # 
  # cmp operates like <=>
  #   for left <=> right
  #   returning -1 if left  < right
  #              0 if left == right
  #              1 if left >  right
  #
  def cmp(left, right)
    puts "cmp #{left}, #{right}"

    return  0 if left.empty? && right.empty?
    return -1 if left.empty?
    return  1 if right.empty?

    l = left.shift
    r = right.shift

    cmp_first = case [check_type(l), check_type(r)]
                when %i[int arr]
                  cmp([l], r)

                when %i[arr int]
                  cmp(l, [r])

                when %i[arr arr]
                  cmp(l, r)

                when %i[int int]
                  puts "#{l} <=> #{r}"
                  l <=> r
                end

    puts "cmp_first #{cmp_first}"

    return -1 if cmp_first == -1
    return 1 if cmp_first == 1

    cmp(left, right)
  end

  def run
    @list.map{|left, right|
      c = cmp(left, right)
      puts "RETURN: #{c}"
      c
    }.each_with_index
        .map{|r, n| [r, n]}
        .filter{|r, _| r == -1}
        .map{|_, n| n + 1}
        .reduce(&:+)
  end
end
