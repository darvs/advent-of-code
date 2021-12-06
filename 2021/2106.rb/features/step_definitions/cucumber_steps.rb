# frozen_string_literal: true

Given('the fish in file {string}') do |arg1|
  @fish = Lanternfish.from_file(arg1)
end

Then('after {int} days there would be {int} fish') do |arg1, arg2|
  expect(@fish.run(arg1)).to eq(arg2)
end
