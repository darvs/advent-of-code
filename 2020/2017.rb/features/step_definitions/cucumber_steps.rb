# frozen_string_literal: true

Given('the starting map in {string}') do |string|
  @filename = string
end

Then('after {int} cycles, {int} are left active') do |int, int2|
  expect(ConwayCubes.from_file(@filename).run(int)).to eq(int2)
end
