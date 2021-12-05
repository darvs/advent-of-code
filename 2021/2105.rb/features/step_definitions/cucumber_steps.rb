# frozen_string_literal: true

Given('the coordinates in file {string}') do |arg1|
  @hv = HydrothermalVenture.from_file(arg1)
end

Given(/^we ignore diagonals$/) do
  @hv.ignore_diagonals
end

Then('the lines overlap at {int} points') do |arg1|
  expect(@hv.overlap).to eq(arg1)
end
