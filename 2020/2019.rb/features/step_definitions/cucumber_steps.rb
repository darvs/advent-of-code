# frozen_string_literal: true

Given(/^the grammar in file "([^"]*)"$/) do |arg1, table|
  @filename = arg1
  @data = table.hashes
end

Then(/^the messages should be validated$/) do
  @data.each{|row|
    expect(Grammar.from_file(@filename).check_message(row['message'])).to eq(row['valid'].to_i)
  }
end

Given(/^the grammar and messages in file "([^"]*)"$/) do |arg1|
  @filename = arg1
end

Then(/^(\d+) messages should be valid$/) do |arg1|
  expect(Grammar.from_file(@filename).check_all_messages).to eq(arg1.to_i)
end
