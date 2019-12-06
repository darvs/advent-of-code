# frozen_string_literal: true

require_relative '../../lib/1904.rb'

Given('the password {int}') do |int|
  @num = int
end

Then('it is valid') do
  expect(SecureContainer.check(@num)).to be(true)
end

Then('it is invalid') do
  expect(SecureContainer.check(@num)).to be(false)
end

Then('it is valid for part two') do
  expect(SecureContainer.check(@num, 2)).to be(true)
end

Then('it is invalid for part two') do
  expect(SecureContainer.check(@num, 2)).to be(false)
end

Given('the range {int} to {int}') do |int, int2|
  @min = int
  @max = int2
end

Then('{int} passwords meet the criteria for the first part') do |int|
  expect(SecureContainer.check_range(@min, @max, 1)).to eq(int)
end

Then('{int} passwords meet the criteria for the second part') do |int|
  expect(SecureContainer.check_range(@min, @max, 2)).to eq(int)
end
