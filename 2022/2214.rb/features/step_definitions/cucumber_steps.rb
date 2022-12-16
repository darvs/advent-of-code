# frozen_string_literal: true

Given('the content of file {string}') do |arg1|
  @filename = arg1
end

Then(/^(\d+) units of sand rest before falling into the abyss\.$/) do |arg1|
  expect(Regolith.from_file(@filename).rest).to eq(arg1)
end
