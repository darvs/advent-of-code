# frozen_string_literal: true

def calc_fuel_recursive(mass, recursive)
  f = [0, (mass / 3) - 2].max

  if recursive && f.positive?
    f + calc_fuel_recursive(f, recursive)
  else
    f
  end
end

def total_fuel(filename, recursive)
  File.open(File.join('data', filename))
      .map(&:strip)
      .reject(&:empty?)
      .map(&:to_i)
      .map{|m| calc_fuel_recursive(m, recursive)}
      .reduce(:+)
end
