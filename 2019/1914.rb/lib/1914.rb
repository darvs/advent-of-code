# frozen_string_literal: true

# Stoichiometry is a section of chemistry that involves using relationships
# between reactants and/or products in a chemical reaction to determine
# desired quantitative data.
class Stoichiometry
  attr_reader :ore

  def initialize(recipes)
    @ore = transform(recipes, [[:FUEL, 1]])
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip)
      .each_with_object({}){|l, h| parse(h, l)})
  end

  def self.parse(hash, line)
    parsed = line.split(' => ').map{|s|
      s.scan(/(\d+)\s(\w+)/).map{|num, r| [r.to_sym, num.to_i]}
    }.reverse

    result, qty = parsed.shift.flatten
    hash[result] = { qty: qty, recipe: parsed.flatten(1) }
  end

  def scale(recipe, qty)
    return recipe if recipe[:qty] >= qty

    factor = (qty.to_f / recipe[:qty]).ceil

    { qty: recipe[:qty] * factor,
      recipe: recipe[:recipe].map{|k, v| [k, v * factor]} }
  end

  def transform(recipes, objectives, leftovers = Hash.new(0), ore = 0)
    return ore if objectives.empty?

    goal, qty = objectives.shift

    return transform(recipes, objectives, leftovers, ore + qty) if goal == :ORE

    # See if we already have what we need in the leftovers
    from_leftovers = [leftovers[goal], qty].min
    leftovers[goal] -= from_leftovers
    qty -= from_leftovers

    # Did we fulfill everything ftom the leftovers?
    return transform(recipes, objectives, leftovers, ore) if qty.zero?

    # Scale the recipe to make enough to cover qty
    scaled = scale(recipes[goal], qty)

    # If we produced too much there will be some leftovers
    leftovers[goal] += scaled[:qty] - qty if scaled[:qty] > qty

    transform(recipes, scaled[:recipe] + objectives, leftovers, ore)
  end
end
