# frozen_string_literal: true

Given('the values in file {string}') do |arg1|
  @p = Program.from_file(arg1)
end

Then(/^the result is (\d+)$/) do |arg1|
  expect(@p.run(always_do: true)).to eq(arg1)
end

Then(/^the result with do's and don'ts is (\d+)$/) do |arg1|
  expect(@p.run(always_do: false)).to eq(arg1)
end
