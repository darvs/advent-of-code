# frozen_string_literal: true

Given('the string in file {string}') do |arg1|
  @decoder = PacketDecoder.from_file(arg1)
end

Then(/^the sum of versions is (\d+)$/) do |arg1|
  expect(@decoder.sum_of_versions).to eq(arg1)
end

Given(/^the table$/) do |table|
  @data = table.hashes
end

Then(/^the our versions sums match$/) do
  @data.each{|row|
    @string = row['string']
    @sum = row['version_sum'].to_i
    expect(PacketDecoder.from_string(@string).sum_of_versions).to eq(@sum)
  }
end

Then(/^the our results match$/) do
  @data.each{|row|
    @string = row['string']
    @result = row['result'].to_i
    expect(PacketDecoder.from_string(@string).solve).to eq(@result)
  }
end

Then(/^the sum is (\d+)$/) do |arg1|
  expect(@decoder.solve).to eq(arg1) 
end
