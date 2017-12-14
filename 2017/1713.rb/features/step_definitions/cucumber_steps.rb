require_relative '../../lib/1713.rb'

Given('depths and ranges in the file {string}') do |string|
  @firewall = read_file(string)
end

Then('the severity of the trip is {int}.') do |int|
  expect(severity(@firewall)).to eq(int)
end

Then("a delay of {int} would make it completely safe.") do |int|
  expect(safe_with_delay(@firewall)).to eq(int)
end

