# frozen_string_literal: true

Given('the rules in {string}') do |string|
  @rules = string
end

Then('{int} bag colors can eventually contain at least one shiny gold bag') do |int|
  expect(Handbags.from_file(@rules).contain).to eq(int)
end

Then('a shiny gold bag contains {int} bags') do |int|
  expect(Handbags.from_file(@rules).contain_part2).to eq(int)
end
