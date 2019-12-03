# frozen_string_literal: true

require_relative '../../lib/1902.rb'

Given('a program of {string}') do |string|
  @pgm = IntcodeInterpreter.new(string)
end

Given('the program in file {string}') do |string|
  @filename = string
  @pgm = IntcodeInterpreter.from_file(string)
end

Then('if the error is set to {int}') do |int|
  @pgm.set_error_val(int)
end

Then('the result should be {string}') do |string|
  expect(@pgm.run.to_s).to eq(string)
end

Then('at the end, position {int} should be {int}') do |int, int2|
  expect(@pgm.run.peek(int)).to eq(int2)
end

Then('when position {int} is {int}') do |int, int2|
  @pos = int
  @val = int2
end

Then('the error should be {int}') do |int|
  expect(IntcodeInterpreter.loop(@filename, @pos, @val)).to eq(int)
end
