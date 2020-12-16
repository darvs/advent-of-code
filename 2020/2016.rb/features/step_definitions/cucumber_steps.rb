# frozen_string_literal: true

Given('the tickets in {string}') do |string|
  @filename = string
end

Then('the scanning error rate is {int}') do |int|
  expect(Tickets.from_file(@filename).invalid_ticket_rate).to eq(int)
end
