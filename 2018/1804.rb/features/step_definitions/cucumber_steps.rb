require_relative "../../lib/1804.rb"

Given("the schedule in {string}") do |string|
  @guard_with_most_minutes_asleep, @minute_most_asleep_for_guard_with_most_minutes_asleep, @guard_most_frequently_asleep_on_same_minute = exec_file(string)
end

Then("the guard with the most minutes asleep would be guard number {int}") do |int|
  expect(@guard_with_most_minutes_asleep).to eq(int)
end

Then("the guard with the most minutes asleep would be most asleep in minute number {int}") do |int|
  expect(@minute_most_asleep_for_guard_with_most_minutes_asleep).to eq(int)
end

Then("the answer to part one would be {int} * {int} = {int}") do |int, int2, int3|
  expect(@guard_with_most_minutes_asleep).to eq(int)
  expect(@minute_most_asleep_for_guard_with_most_minutes_asleep).to eq(int2)
  expect(@guard_with_most_minutes_asleep * @minute_most_asleep_for_guard_with_most_minutes_asleep).to eq(int3)
end 

Then("the guard asleep the most in one minute would be guard number {int}") do |int|
  expect(@guard_most_frequently_asleep_on_same_minute[:guard]).to eq(int)
end

Then("the minute most asleep by one guard would be minute {int}") do |int|
  expect(@guard_most_frequently_asleep_on_same_minute[:minute]).to eq(int)
end

Then("the answer to part two would be {int} * {int} = {int}") do |int, int2, int3|
  expect(@guard_most_frequently_asleep_on_same_minute[:guard]).to eq(int)
  expect(@guard_most_frequently_asleep_on_same_minute[:minute]).to eq(int2)
  expect(@guard_most_frequently_asleep_on_same_minute[:guard] * @guard_most_frequently_asleep_on_same_minute[:minute]).to eq(int3)
end
