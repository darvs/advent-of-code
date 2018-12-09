# frozen_string_literal: true

require_relative "../../lib/1807.rb"

Given("an input file named {string}") do |string|
  @order = exec_file(string)
end

Then("the correct order should be {string}") do |string|
  expect(@order).to eq(string)
end
