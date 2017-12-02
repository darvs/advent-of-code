require_relative '../lib/2017d01'

puzzle_key = File.read("data/2017d01.in").strip

describe "Part One" do
	expected = {
		"1122": 3,
		"1111": 4,
		"1234": 0,
		"91212129": 9  
	}
	expected.each do |input, output|
		it "returns #{output} for #{input}" do
			expect(d01p1(input)).to eq(output)
		end
	end
	
	it "works for our puzzle key" do
		expect(d01p1(puzzle_key)).to eq(1177)
	end
end

describe "Part Two" do
	expected = {
		"1212": 6,
		"1221": 0,
		"123425": 4,
		"123123": 12,
		"12131415": 4
	}
	expected.each do |input, output|
		it "returns #{output} for #{input}" do
			expect(d01p2(input)).to eq(output)
		end
	end

	it "works for our puzzle key" do
		expect(d01p2(puzzle_key)).to eq(1060)
	end
end
