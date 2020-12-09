# frozen_string_literal: true

Given('the numbers in {string}') do |string|
  @filename = string
end

Given('a preamble of {int} numbers') do |int|
  @preamble = int
end

Given('checking the last {int} numbers') do |int|
  @checking = int
end

Then('the first non-valid number is {int}') do |int|
  @xmas = XMAS.from_file(@filename)
  @invalid = @xmas.check(@preamble, @checking)
  expect(@invalid).to eq(int)
end

Then('adding the smallest and largest numbers is {int}') do |int|
  expect(@xmas.part2(@invalid)).to eq(int)
end
