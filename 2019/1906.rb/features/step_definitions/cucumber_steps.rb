# frozen_string_literal: true

Given('the orbits in file {string}') do |string|
  @orbits = Orbits.new(string)
end

Then('the total number of orbits is {int}') do |int|
  expect(@orbits.number_of_orbits).to eq(int)
end

Then('the minimum number of orbital transfers to move between {string} and {string} is {int}') do |string, string2, int|
  expect(@orbits.min_orbital_transfers(string, string2)).to eq(int)
end
