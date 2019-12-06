require_relative '../../lib/1901.rb'

Given('a mass of {int}') do |int|
  @mass = int
end

Then('the amount of fuel required would be {int}') do |int|
  expect(calc_fuel_recursive(@mass, false)).to eq(int)
end

Given('the list of masses in file {string}') do |string|
  @filename = string
end

Then('the total amount of fuel required would be {int}') do |int|
  expect(total_fuel(@filename, false)).to eq(int)
end

Then('the amount of fuel required with the recursive method would be {int}') do |int|
  expect(calc_fuel_recursive(@mass, true)).to eq(int)
end

Then('the total amount of fuel required with the recursive method would be {int}') do |int|
  expect(total_fuel(@filename, true)).to eq(int)
end
