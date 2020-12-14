# frozen_string_literal: true

Given('the code in {string}') do |string|
  @filename = string
end

Then('the total of all memory values is {int}') do |int|
  expect(Program.from_file(@filename).run).to eq(int)
end

Then('a memory adress decoder would output {int}') do |int|
  expect(MAD.from_file(@filename).run).to eq(int)
end
