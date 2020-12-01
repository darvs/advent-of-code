# frozen_string_literal: true

Given('the number in file {string}') do |string|
  @expense = Expense.from_file(string)
end

Then('the answer would be {int}') do |int|
  expect(@expense.run).to eq(int)
end
