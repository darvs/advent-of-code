# frozen_string_literal: true

Given('a program of {string}') do |string|
  @pgm = IntcodeInterpreter.new(string)
end

Given('the program in file {string}') do |string|
  @pgm = IntcodeInterpreter.from_file(string)
end

Given('the input {string}') do |string|
  @pgm.input = string
end

When('the machine is run') do
  @pgm.run
end

Then('the output should be {string}') do |string|
  expect(@pgm.output).to eq(string)
end
