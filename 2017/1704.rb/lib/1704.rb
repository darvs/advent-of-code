def charivari(str)
	str.chars.sort.reduce(:+)
end

def validate_string(str, check_anagrams)
	set = Set.new
	str.split
		.map {|word| check_anagrams ? charivari(word) : word}
		.map {|word| set.add?(word) ? 0 : 1}
		.reduce(:+) == 0
end

def validate_file(filename, check_anagrams)
	File.open(File.join("data",filename)).map{|line| validate_string(line,check_anagrams)? 1 : 0 }.reduce(:+)
end
