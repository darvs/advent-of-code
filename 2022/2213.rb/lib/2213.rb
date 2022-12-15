# frozen_string_literal: true

# Annoying List
class DistressSignal
  def initialize(list)
    @list = list.map{|string|
      #eval(string)
      the_lesser_of_two_evals(string.chars).first
    }
    #@list.each{|e| puts e.to_s}
  end

  # Formerly known as 'parse_packet', I realized that this
  # is absolutely useless. But since I wrote it and I was
  # needlessly proud of it, we're going to keep it.
  #
  def the_lesser_of_two_evals(tokens)
    list = []

    until tokens.empty?
      head = tokens.shift

      case head
      when '['
        list.append(the_lesser_of_two_evals(tokens))
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
        tokens.unshift(head)
        list.append(n.to_i)
      end
    end

    list
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:chomp).reject(&:empty?))
  end

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
    #puts "cmp #{left}, #{right}"

    return  0 if left.empty? && right.empty?
    return -1 if left.empty?
    return  1 if right.empty?

    l = left.first
    r = right.first

    cmp_first = case [check_type(l), check_type(r)]
                when %i[int arr]
                  cmp([l], r)

                when %i[arr int]
                  cmp(l, [r])

                when %i[arr arr]
                  cmp(l, r)

                when %i[int int]
                  #puts "#{l} <=> #{r}"
                  l <=> r
                end

    #puts "cmp_first #{cmp_first}"

    return -1 if cmp_first == -1
    return 1 if cmp_first == 1

    cmp(left.clone.drop(1), right.clone.drop(1))
  end

  def run
    @list.each_slice(2).map{|left, right|
      cmp(left.clone, right.clone)
    }.map{|c|
      #puts "RETURN: #{c}"
      c
    }
         .each_with_index
         .map{|r, n| [r, n]}
         .filter{|r, _| r == -1}
         .map{|_, n| n + 1}
         .reduce(&:+)
  end

  def decoder_key
    # Add the divider packets
    dividers = ['[[2]]', '[[6]]']
    dividers.each{|div| @list.append(the_lesser_of_two_evals(div.chars).first)}

    @list.sort{|a, b| cmp(a, b)}.map(&:to_s)
         .each_with_index.map{|e, i| [e, i + 1]}
         .filter{|e, _| dividers.include?(e)}
         .map{|_, i| i}
         .reduce(&:*)
  end
end
