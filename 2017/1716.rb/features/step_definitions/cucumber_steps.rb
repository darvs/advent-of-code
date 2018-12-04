require_relative "../../lib/1716.rb"

Given("the programs {string}") do |string|
  @programs = string  
end

Given("the sequence of dance moves in {string}") do |string|
  @dance_moves = string
end

Then("the ending positions should be {string} after performing it {int} times") do |string, int|
  expect(exec_file(@dance_moves, @programs.clone, int)).to eq(string)
end
