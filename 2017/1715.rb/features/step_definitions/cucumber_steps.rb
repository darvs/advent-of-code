require_relative '../../lib/1715.rb'

Before do
  # Generators
  @gen = {}
  @matches = 0
end

Given("a generator {string} with a starting value of {int} and a factor of {int}") do |string, int, int2|
  @gen[string] = Generator.new(int, int2)
end

Then("after {int} steps the total number of matches would be {int}") do |int, int2|
  (1..int).each{
    @gen.values.each(&:step)
    @matches += 1 if @gen.values.map(&:match_value).uniq.length == 1
  }

  expect(@matches).to eq(int2)
end

Then("generated values would be {int} for {string}") do |int, string|
  expect(@gen[string].value).to eq(int)
end

Given("generator {string} only looks for values that are multiples of {int}") do |string, int|
  @gen[string].value_needs_to_be_a_multiple_of = int
end
