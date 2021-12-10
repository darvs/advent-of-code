# frozen_string_literal: true

# ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn
class Syntax
  OPENERS = ['(', '[', '{', '<'].freeze
  CLOSERS = [')', ']', '}', '>'].freeze

  ERROR_POINTS = { ')' => 3, ']' => 57, '}' => 1197, '>' => 25137 }.freeze
  AUTO_COMPLETE_POINTS = { ')' => 1, ']' => 2, '}' => 3, '>' => 4 }.freeze


  def initialize(input)
    @list = input
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip).map(&:chars).map(&:reverse))
  end

  def error
    @list.map{|line| parse(line)}.reject{|x| x.is_a?(Array)}.map{|x| ERROR_POINTS[x]}.sum
  end

  def auto_complete
    answer = @list.map{|line| parse(line)}.select{|x| x.is_a?(Array)}.map{|answer|
      p "answer #{answer}"
      answer.inject(0){|v, x|
      p "v #{v}, x is #{x} worth #{AUTO_COMPLETE_POINTS[x]}"
      v = (5 * v + AUTO_COMPLETE_POINTS[x])
      p v
    }}.sort

    answer[(answer.length + 1) / 2 - 1]
  end

  def parse(line, stack = [])
    return stack.map{|c| corresponding(c)}.reverse if line.empty?

    head = line.pop
    if OPENERS.include?(head)
      p "push #{head}"
      stack.push(head)
    elsif head != corresponding(stack.pop)
      p "wrong #{head}"
      return head
    end

    p "passed #{line}"

    parse(line, stack)
  end

  def corresponding(c)
    return false if c.empty?

    p "corrsponding #{c}"

    CLOSERS[OPENERS.find_index(c)]
  end
end
