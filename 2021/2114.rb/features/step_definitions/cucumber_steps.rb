# frozen_string_literal: true

Given('the rules in file {string}') do |arg1|
  @filename = arg1
end

Given('the table') do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  @data = table.hashes
end

Then('my polymers are verified') do
  @data.each{|line|
    expect(Polymer.from_file(@filename).run(line['step'].to_i).to_s).to eq(line['polymer'])
  }
end

Then('my lengths are verified') do
  @data.each{|line|
    expect(Polymer.from_file(@filename).run(line['step'].to_i).to_s.length).to eq(line['length'].to_i)
  }
end

Given('after {int} steps') do |arg1|
  @steps = arg1
end

Then(/^the difference in count is (\d+)$/) do |arg1|
  expect(Polymer.from_file(@filename).run(@steps).most_common_minus_least_common).to eq(arg1)
end
