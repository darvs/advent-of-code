require_relative "../../lib/1704.rb"

Before do
	@check_anagrams = false
end

Given("a list of words {string}") do |string|
	@str = string
end

Then("the passphrase is valid") do
	expect(validate_string(@str, @check_anagrams)).to eq(true) 
end

Then("the passphrase is invalid") do
	expect(validate_string(@str, @check_anagrams)).to eq(false) 
end

Given("the file {string}") do |string|
	@filename = string
end

Then("there are {int} passphrases that are valid") do |int|
	expect(validate_file(@filename, @check_anagrams)).to eq(int)
end

Given("the fact that passphrases must also not contain anagrams") do
	@check_anagrams = true
end
