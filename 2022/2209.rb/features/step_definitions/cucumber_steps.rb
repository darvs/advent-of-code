# frozen_string_literal: true

Given('the content of file {string}') do |arg1|
  @rope = Rope.from_file(arg1)
end

Then(/^the tail visits (\d+) positions at least once$/) do |arg1|
  expect(@rope.position_count).to eq(arg1)
end
