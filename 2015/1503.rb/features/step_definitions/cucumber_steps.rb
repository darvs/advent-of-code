# frozen_string_literal: true

Given('the itinerary {string}') do |string|
  @itinerary = Itinerary.new(string)
end

Given('the itinerary in file {string}') do |string|
  @itinerary = Itinerary.from_file(string)
end

Then('{int} Santa\(s) would visit {int} houses') do |int, int2|
  expect(@itinerary.run(int)).to eq(int2)
end
