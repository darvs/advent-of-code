# frozen_string_literal: true

require_relative '../../lib/1903.rb'

Given('the wires in {string}') do |string|
  @wires = WireChecker.new(string)
end

Then('the closest intersection should be at distance {int}') do |int|
  expect(@wires.intersection).to eq(int)
end

Then('the shortest wire length to an intersection would be {int}') do |int|
  expect(@wires.wire_length).to eq(int)
end
