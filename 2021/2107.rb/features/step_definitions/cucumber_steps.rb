# frozen_string_literal: true

Given('the positions in file {string}') do |arg1|
  @treachery = TreacheryOfWhales.from_file(arg1)
end

Given('using crab engineering measurements') do
  @treachery.use_crab_engineering
end

Then('the most economical fuel amount would be {int}') do |arg1|
  expect(@treachery.run).to eq(arg1)
end
