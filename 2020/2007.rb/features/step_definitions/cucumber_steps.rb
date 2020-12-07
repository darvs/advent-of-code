# frozen_string_literal: true

Given('the rules in {string}') do |string|
  @rules = string
end

Then('{int} bag colors can eventually contain at least one shiny gold bag') do |int|
  expect(Handbags.from_file(@rules).contain).to eq(int)
end
