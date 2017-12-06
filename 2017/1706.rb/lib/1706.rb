def banks_from_string(str)
	str.split.reject{|x| x == '\"'}.map{|x| x.to_i}
end

def banks_from_file(filename)
	File.read(File.join("data",filename)).split.map{|x| x.to_i}
end

def string_from_banks(banks)
	banks.join(" ")
end

def pick(banks)
	max = banks.max
	max_idx = 0
	banks.each_with_index{|x, idx| max_idx = idx; break if x == max;}

	return max_idx, max
end

def one_step(banks)
	idx, max = pick(banks)

	banks[idx] = 0
	for offset in 1..max do
		other = (idx+offset)%(banks.length) 
		banks[other] += 1
	end

	return banks
end

def detect_infinite_loop(banks)
	hash = {}
	loop do
		banks = one_step(banks)
		break if hash.has_key?(banks)
		hash[banks] = hash.length+1
	end

	pos = hash.length+1
	len = pos - hash[banks]

	return pos, len
end
