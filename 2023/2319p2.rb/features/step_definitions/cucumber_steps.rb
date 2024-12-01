# frozen_string_literal: true

Given('the values in file {string}') do |arg1|
  @gen = Generator.from_file(arg1)
end

Then(/^the sum of ratings of accepted parts is (\d+)$/) do |arg1|
  expect(@gen.run).to eq(arg1)
end
