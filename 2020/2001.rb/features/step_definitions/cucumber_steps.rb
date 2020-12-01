# frozen_string_literal: true

Given('the number in file {string}') do |string|
  @expense = Expense.from_file(string)
end

Then('the multiplication of {int} numbers would be {int}') do |int, int2|
  expect(@expense.run(int)).to eq(int2)
end
