# frozen_string_literal: true

Given('the seats in {string}') do |string|
  @filename = string
end

Then('{int} people would be seated once everybody stops moving') do |int|
  expect(Seats.from_file(@filename).run_til_stable).to eq(int)
end
