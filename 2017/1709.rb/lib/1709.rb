def trash(str)
	clone = str.dup

	while clone.gsub!(/!./,"")
		# do gsub
	end

	while clone.gsub!(/(<)(.*?)(>)/) {
		matched = Regexp.last_match[2]
		matched.gsub!(/./, 'W')
	}
	end

	return clone
end

def all_garbage(str)
	clean = trash(str)
	clean.gsub("W","") == ""
end

def count_groups(str)
	clean = trash(str)
	return clean.scan(/{/).size
end

def score(str)
	current = 0
	trash(str).chars.map{|c|
		case c
		when "{"
			current += 1
		when "}"
			current -= 1
			0
		else
			0
		end
	}.reduce(:+)
end

def trash_count(str)
	trash(str).chars.map{|c| if c=="W" then 1 else 0 end}.reduce(:+) || 0
end

def file(str)
	File.read(File.join("data", str))
end
