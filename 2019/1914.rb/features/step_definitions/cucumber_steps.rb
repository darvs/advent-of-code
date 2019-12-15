# frozen_string_literal: true

Given('the program in file {string}') do |string|
  @s = Stoichiometry.from_file(string)
end

Then('the reactions to produce {int} FUEL require {int} ORE') do |int, int2|
  expect(@s.ore).to eq(int2)
end
