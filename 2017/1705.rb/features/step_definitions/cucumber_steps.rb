require_relative "../../lib/1705.rb"

Given("the program is {string}") do |string|
  @code = string
  @pc = 0
  @jumps = :normal
end

Given("the program file {string}") do |string|
  @code = read_file(string)
  @pc = 0
end

Given("the PC is {int}") do |int|
  @pc = int
end

Given("the jumps are stranger") do
  @jumps = :stranger
end

Then("after a single step the program should be {string}") do |string|
  @pc2, @result = one_step(@pc, @code)

  expect(@result).to eq(string)
end

Then("the PC should be {int}") do |int|
  expect(@pc2).to eq(int)
end

Then("it should exit in {int} steps") do |int|
  expect(load(@code, @jumps)).to eq(int)
end

