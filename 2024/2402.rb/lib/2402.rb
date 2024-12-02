# frozen_string_literal: true

# Reports
class Reports
  def initialize(list)
    @list = list.map{|l| l.split(' ').map(&:to_i)}
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def safe(dampen=false)
    @list.map{|l| dampened_safe(l, dampen)}.sum
  end

  def dampened_safe(l, dampen)
    is_safe = safe_line(l)
    return is_safe if is_safe == 1 || !dampen

    (0..(l.length - 1)).to_a.each {|p|
      new_l = l.dup
      new_l.delete_at(p)

      return 1 if safe_line(new_l) == 1
    }
    return 0
  end

  def safe_line(line)
    pos_diff = line.each_cons(2).map{|a, b|
      return 0 unless (a - b).abs.between?(1, 3)

      (b - a).positive? ? 1 : 0
    }.sum

    (pos_diff.zero? or (pos_diff == (line.length - 1))) ? 1 : 0
  end
end
