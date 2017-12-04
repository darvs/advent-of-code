def charivari(str)
	str.chars.sort.reduce(:+)
end

def validate_string(str, check_anagrams)
	word_map = {}
	str.split
		.map {|word| check_anagrams ? charivari(word) : word} 
		.map {|word| 
			if word_map.key?(word) then
				1
			else
				word_map[word] = 1; 0
			end
	}.reduce(:+) == 0
end

def validate_file(filename, check_anagrams)
	File.open("data/#{filename}").map{|line| validate_string(line,check_anagrams)? 1 : 0 }.reduce(:+)
end

