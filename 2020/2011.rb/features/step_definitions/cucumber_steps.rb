# frozen_string_literal: true

Given('the seats in {string}') do |string|
  @filename = string
  @infinite = false
end

Given('a tolerance of {int} people') do |int|
  @tolerance = int
end

Given('an infinite horizon') do
  @infinite = true
end

Then('{int} people would be seated once everybody stops moving') do |int|
  expect(Seats.from_file(@filename).run_til_stable(@tolerance, @infinite)).to eq(int)
end
