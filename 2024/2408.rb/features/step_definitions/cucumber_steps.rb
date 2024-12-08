# frozen_string_literal: true

Given('the values in file {string}') do |arg1|
  @p = Program.from_file(arg1)
end

Then(/^the result is (\d+)$/) do |arg1|
  expect(@p.run).to eq(arg1)
end

When(/^there is resonance$/) do
  @p.add_resonance
end
