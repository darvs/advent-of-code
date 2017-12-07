def read_line(string) hash = Hash.new
	if /(.+?) \(([0-9]+)\)(?: \-\> (.+))?/ =~ string then
		hash[:name] = $1
		hash[:weight] = $2.to_i
		hash[:supported] = $3.nil? ? [] : $3.gsub(/[\s,]/," ").split
	end
	return hash
end

def read_file(filename)
	programs = Hash.new
	File.open(File.join("data", filename))
		.map{|str| read_line(str)} # parse each line as a program
		.map{|line| programs[line[:name]]=line} # create a hash entry for each program with the name as the key
		.map{|this| this[:supported].map{|sup| # For each program (this), for each of its supported programs...
				programs[sup][:parent] = this[:name] # set the supported program's parent to (this) program
	 		}
		}
	return programs
end

def bottom(programs)
	# return the name of the only program which doesn't have a parent set.
	return programs.select{|prg| programs[prg].has_key?(:parent) == false}.map{|k,v| v[:name]}.first
end
