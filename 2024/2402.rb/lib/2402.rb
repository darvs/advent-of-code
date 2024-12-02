# frozen_string_literal: true

# Reports
class Reports
  def initialize(list)
    @list = list.map{|l| l.split(' ').map(&:to_i)}
    puts "@list: #{@list}"
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def safe
    @list.map{|l| safe_line(l)}.sum
  end

  def safe_line(line)
    p "line: #{line}"
    pos_diff = line.each_cons(2).map{|a, b|
      return 0 unless (a - b).abs.between?(1, 3)

      (b - a).positive? ? 1 : 0
    }.sum

    p "pos_diff: #{pos_diff}"

    v  = (pos_diff.zero? or (pos_diff == (line.length - 1))) ? 1 : 0
    p "#{v}"
    v
  end
end
