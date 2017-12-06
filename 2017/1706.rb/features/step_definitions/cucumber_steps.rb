require_relative "../../lib/1706.rb"

Given("the memory banks {string}") do |string|
    @banks = banks_from_string(string)
end

Then("bank # {int} with {int} items would be chosen for redistribution") do |int, int2|
    idx, max = pick(@banks)
    expect(idx).to eq(int) and expect(max).to eq(int2)
end

Then("after one redistribution it should look like {string}") do |string|
    expect(string_from_banks(one_step(@banks))).to eq(string)
end

Then("it would take {int} steps to enter an infinite loop") do |int|
    steps, @len = detect_infinite_loop(@banks)
    expect(steps).to eq(int)
end

Then("the loop would have a length of {int}") do |int|
    expect(@len).to eq(int)
end

Given("the memory bank file {string}") do |string|
    @banks = banks_from_file(string)
end
