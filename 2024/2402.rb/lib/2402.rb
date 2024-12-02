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

  def safe(dampen = false)
    @list.map{|l| dampened_safe(l, dampen)}.filter{|ret| ret}.count
  end

  def dampened_safe(l, dampen)
    is_safe = safe_line(l)
    return is_safe if is_safe || !dampen

    (0..(l.length - 1)).to_a.each {|p|
      new_l = l.dup
      new_l.delete_at(p)

      return true if safe_line(new_l)
    }
    false
  end

  def safe_line(line)
    pos_diff = line.each_cons(2).map{|a, b|
      return false unless (a - b).abs.between?(1, 3)

      (b - a).positive?
    }.filter{|ret| ret}.count

    # Are they either all decreasing or all increasing
    pos_diff.zero? or pos_diff == (line.length - 1)
  end
end
