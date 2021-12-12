# frozen_string_literal: true

Given('the subpaths in file {string}') do |arg1|
  @cave = Cave.from_file(arg1)
end

Given(/^we can visit one small cave twice$/) do
  @cave.visit_a_small_cave_twice = true
end

Then(/^there is (\d+) different paths$/) do |arg1|
  expect(@cave.number_of_paths).to eq(arg1)
end
