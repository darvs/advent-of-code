# frozen_string_literal: true

Given('the passports in file {string}') do |string|
  @filename = string
  @validation = false
end

Given('stricter validation') do
  @validation = true
end

Then('there would be {int} valid passports') do |int|
  expect(Passports.from_file(@filename).run(@validation)).to eq(int)
end
