# frozen_string_literal: true

Given('the moon positions in file {string}') do |string|
  @sys = PlanetarySystem.from_file(string)
end

When('{int} steps have been calculated') do |int|
  @sys.run(int)
end

Then('the total energy in the system would be {int}') do |int|
  expect(@sys.energy).to eq(int)
end
