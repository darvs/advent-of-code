def trash(str)
	clone = str.dup

	while clone.gsub!(/!./,"XX")
		# do gsub
	end

	while clone.gsub!(/(<.*?>)/, "_")
		# do gsub
	end

	return clone
end

def all_garbage(str)
	clean = trash(str)
	clean.match(/_+?/)[0].length == clean.length
end

def count_groups(str)
	clean = trash(str)
	return clean.scan(/{/).size
end

def score(str)
	current = 0
	m = trash(str).chars.map{|c|
		case c
		when "{"
			current += 1
		when "}"
			current -= 1
			0
		else
			0
		end
	}
	m.reduce(:+)
end

def file(str)
	File.read(File.join("data", str))
end
