# frozen_string_literal: true

require_relative "../../lib/1807.rb"

Before do
  @order = ""
  @time = 0
end

Given("an input file named {string}") do |string|
  @file = string
  @n_workers = 1
  @time_completion_base = 0
end

Given("{int} workers") do |int|
  @n_workers = int
end

Given("a time completion base of {int} seconds") do |int|
  @time_completion_base = int
end

Then("the correct order should be {string}") do |string|
  if @order.empty? && @time.zero?
    @order, @time = exec_file(@file, @n_workers, @time_completion_base)
  end
  expect(@order).to eq(string)
end

Then("it should be finished in {int} seconds") do |int|
  if @order.empty? && @time.zero?
    @order, @time = exec_file(@file, @n_workers, @time_completion_base)
  end
  expect(@time).to eq(int)
end
