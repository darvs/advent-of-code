# frozen_string_literal: true

Given('the points in file {string}') do |arg1|
  @smoke = Smoke.from_file(arg1)
end

Then('the sum of the risks is {int}') do |arg1|
  expect(@smoke.part1).to eq(arg1)
end

Then('the product of the size of the three largest basins is {int}') do |arg1|
  expect(@smoke.part2).to eq(arg1)
end

Given('the octopi in file {string}') do |arg1|
  @octopi = Octopi.from_file(arg1)
end

Given('after {int} step') do |arg1|
  @octopi.step(arg1)
end

Then('there are {int} glowies') do |arg1|
  expect(@octopi.glowies).to eq(arg1)
end

Then('they all sync at step {int}') do |arg1|
  @octopi.step(0, true)
  expect(@octopi.all_sync).to eq(arg1)
end
