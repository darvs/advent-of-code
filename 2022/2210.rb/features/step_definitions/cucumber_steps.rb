# frozen_string_literal: true

Given('the content of file {string}') do |arg1|
  @crt = Crt.from_file(arg1).run
end

Given(/^the table$/) do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  @data = table.hashes
end

Then(/^all answers should be verified\.$/) do
  @data.each{|row|
    expect(@crt.reg_x_during(row['cycle'].to_i)).to eq(row['value'].to_i)
  }
end

Then(/^the sum of interesting signal strengths must be (\d+)$/) do |arg1|
  expect(@crt.sum_of_interesting_strengths).to eq(arg1)
end
