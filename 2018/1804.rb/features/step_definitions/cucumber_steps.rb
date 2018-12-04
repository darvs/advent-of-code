require_relative "../../lib/1804.rb"

Given("the schedule in {string}") do |string|
  @guard, @minute = exec_file(string)
  puts "Answered: #{@guard} @ #{@minute}"
end

Then("the guard with the most minutes asleep would be guard number {int}") do |int|
  expect(@guard).to eq(int)
end

Then("they would be most asleep in minute number {int}") do |int|
  expect(@minute).to eq(int)
end

Then("multiplying both answers would give us {int}") do |int|
  expect(@guard * @minute).to eq(int)
  
end
