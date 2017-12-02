def line(str)
	arr = str.split
	arr.map {|s| s.to_i}
end

def lowest(line)
	line.min
end

def highest(line)
	line.max
end

def difference(line)
	highest(line) - lowest(line)
end

def load(filename)
	file = File.readlines(File.join(File.dirname(__FILE__), "../data/#{filename}"))
	file.map {|str| line(str)}
end

def checksum(file)
	file.map {|line| difference(line)}.reduce(:+)
end

def even_division(line)
	if line.length == 1 then return 0 end

	head, *tail = *line.sort.reverse
	div = tail.map {|x| if head % x == 0 then head/x else 0 end}
		.select {|x| x > 0}

	if not div.empty? then
		return div.first
	else
		return even_division(tail)
	end
end

def even_division_checksum(file)
	file.map {|line| even_division(line)}.reduce(:+)
end
