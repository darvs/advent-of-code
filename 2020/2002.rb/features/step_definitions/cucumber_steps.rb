# frozen_string_literal: true

Given('the policies and passwords in file {string}') do |string|
  @passwd = Passwords.from_file(string)
end

Then("according to rule {int} there would be {int} valid passwords") do |int, int2|
  expect(@passwd.check(int)).to eq(int2)
end
