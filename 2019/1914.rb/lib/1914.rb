# frozen_string_literal: true

# Stoichiometry is a section of chemistry that involves using relationships
# between reactants and/or products in a chemical reaction to determine
# desired quantitative data.
class Stoichiometry
  attr_reader :ore

  def initialize(recipes)
    p [:initialize, recipes]
    @ore = create(recipes, [[:FUEL, 1]])
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

  def create(recipes, objectives, leftovers = Hash.new(0), ore = 0)
    return ore if objectives.empty?

    p [:create, objectives, leftovers, ore]

    goal, qty = objectives.shift
    p [goal, qty]

    if goal == :ORE
      return create(recipes, objectives, leftovers, ore + qty)
    end

    left = leftovers[goal]
    leftovers[goal] = [leftovers[goal] - qty, 0].max
    qty = [qty - left, 0].max

    p [:goal, goal, :qty, qty, :objectives, objectives, :leftovers, leftovers, :ore, ore]

    if qty.zero?
      return create(recipes, objectives, leftovers, ore)
    end

    # Dity trick to make a deep copy
    recipe = Marshal.load(Marshal.dump(recipes[goal]))

    p [:recipe, recipe, :qty, qty]

    # The recipe produces too little
    if qty > recipe[:qty]
      factor = (qty.to_f/recipe[:qty]).ceil
      recipe[:qty] *= factor
      recipe[:recipe].map!{|k, v| [k, v * factor]}
      p [:factor, factor, :new_recipe, recipe]
    end

    # The recipe produces too much
    if recipe[:qty] > qty
      leftovers[goal] = recipe[:qty] - qty
    end

    return create(recipes, recipe[:recipe] + objectives, leftovers, ore)
  end

end
