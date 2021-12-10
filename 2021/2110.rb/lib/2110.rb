# frozen_string_literal: true

# ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn
class Syntax
  OPENERS = ['(', '[', '{', '<'].freeze
  CLOSERS = [')', ']', '}', '>'].freeze

  ERROR_POINTS = { ')' => 3, ']' => 57, '}' => 1197, '>' => 25_137 }.freeze
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
    scores = @list.map{|line| parse(line)}.select{|x| x.is_a?(Array)}.map{|answer|
      answer.inject(0){|v, x| 5 * v + AUTO_COMPLETE_POINTS[x]}
    }.sort

    scores[(scores.length + 1) / 2 - 1]
  end

  def parse(line, stack = [])
    return stack.reverse if line.empty? # Incomplete line

    head = line.pop
    if OPENERS.include?(head)
      stack.push(corresponding(head))
    elsif head != stack.pop
      return head # Syntax Error
    end

    parse(line, stack)
  end

  def corresponding(c)
    CLOSERS[OPENERS.find_index(c)]
  end
end
