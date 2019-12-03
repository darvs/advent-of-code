# frozen_string_literal: true

require_relative '../../lib/1903.rb'

Given('the wires in {string}') do |string|
  @wires = WireChecker.new(string)
end

Then('the closest intersection should be at distance {int}') do |int|
  pending # Write code here that turns the phrase above into concrete actions
end
