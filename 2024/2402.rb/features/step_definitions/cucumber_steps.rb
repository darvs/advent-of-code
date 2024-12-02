# frozen_string_literal: true

Given('the values in file {string}') do |arg1|
  @r = Reports.from_file(arg1)
end

Then(/^(\d+) reports are safe$/) do |arg1|
  expect(@r.safe).to eq(arg1)
end

Then(/^(\d+) reports are safe with a dampen$/) do |arg1|
  expect(@r.safe(true)).to eq(arg1)
end
