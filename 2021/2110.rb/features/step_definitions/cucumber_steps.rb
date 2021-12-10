# frozen_string_literal: true

Given('the lines in file {string}') do |arg1|
  @syntax = Syntax.from_file(arg1)
end

Then('the syntax score would be {int}') do |arg1|
  expect(@syntax.error).to eq(arg1)
end

Then('the auto-complete score would be {int}') do |arg1|
  expect(@syntax.auto_complete).to eq(arg1)
end
