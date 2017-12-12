def parse_line(pipes, str)
	if str.scan(/(?<pgm>[0-9]+) \<\-\> (?<rhs>[0-9]+(, [0-9]+)*)/) then
		pgm = $~["pgm"]

		$~["rhs"].scan(/[0-9]+/) {|l|
			pipes[pgm.to_i] += [l.to_i]
		}
	end
end

def read_file(filename)
	# The freeze will prevent reusing the same pointer to [] all the time
	pipes = Hash.new([].freeze)
	File.open(File.join("data", filename)).each{|str| parse_line(pipes, str)}
	return pipes
end

def connected(programs, id, set=Set.new)
	programs[id].each{|i|
		#puts "I:: #{i}"
		if !set.include?(i) then
			set.add(i)
			set += connected(programs, i, set)
		end
	}
	return set
end

def all_connected(programs)
	set_list = []
	merged_sets = Set.new

	programs.each{|id, links|
		if !merged_sets.include?(id) then
			conn = connected(programs, id)
			set_list += [conn]
			merged_sets += conn
		end
	}

	return set_list
end

def count_connected_to(connected, id)
	connected.each{|conn|
		if conn.include?(id) then return conn.size end
	}
	return 0
end
