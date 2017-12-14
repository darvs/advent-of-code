require_relative '../../lib/1714.rb'

Given('a key of {string}') do |string|
  @hashes = calc_all_hashes(string)
end

Then('{int} squares are used in the grid') do |int|
  expect(used(@hashes)).to eq(int)
end

Then('there are {int} regions present') do |int|
  expect(regions(@hashes)).to eq(int)
end
