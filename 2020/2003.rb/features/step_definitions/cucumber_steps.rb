# frozen_string_literal: true

Given('the tree field in file {string}') do |string|
  @filename = string
end

Given('the slope right 3, down 1') do
  @case = 1
end

Given('a pre-defined list of slopes') do
  @case = 2
end

Then('you would encounter {int} trees') do |int|
  expect(Toboggan.from_file(@filename).run(@case)).to eq(int)
end
