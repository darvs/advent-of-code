# frozen_string_literal: true

# Cards
class Wait
  def initialize(lines)
    lines = Array.new(lines)
    parse(lines)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def parse(lines)
    time, distance = lines.map{|l| l.scan(/\d+/).map(&:to_i)}
    @races = time.zip(distance)
    p "races #{@races} time #{time} distance #{distance}"
  end

  # ----------------
  #  Naive solution
  # ----------------

  # def race
  #   @races.map{|time, distance| (1..(time - 1)).map{|t| t * (time - t)}.select{|v| v > distance}.count}.reduce(&:*)
  # end

  # ---------------------------------------
  #  Solution using the quadratic equation
  # ---------------------------------------

  def race
    @races.map{|time, distance|
      a = 1
      b = -time
      c = distance
      lo = ((-b - Math.sqrt(b**2 - (4 * a * c)))/2.0).floor + 1
      hi = time - lo
      #puts "[#{lo}, #{hi}]"
      hi - lo + 1
    }
  end

  def mult(bad_kerning)
    @races = [@races.transpose.map{|r| r.map(&:to_s).reduce(&:concat).to_i}] if bad_kerning
    race.reduce(&:*)
  end
end
