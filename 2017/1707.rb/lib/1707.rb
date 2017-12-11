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

def weight(programs, program_name)
	pgm = programs[program_name]
	if pgm.has_key?(:total_weight) then return pgm[:total_weight] end

	if pgm[:supported].empty? then
		supported_weight = 0
	else
		supported_weight = pgm[:supported].map{|sup| weight(programs, sup)}.reduce(:+)
	end

	pgm[:supported_weight] = supported_weight
	pgm[:total_weight] = pgm[:weight] + supported_weight

	return pgm[:total_weight]
end

def unbalanced(programs, program_name, error=0)
	pgm = programs[program_name]

	if pgm[:supported].empty? then
		# pgm is a leaf
		# The error has to be here.
		return pgm[:weight]-error

	else
		supported_weight_list = pgm[:supported].map{|sup| [programs[sup][:name], programs[sup][:total_weight]]}
		weight_occ = supported_weight_list
			.transpose[1].each_with_object(Hash.new(0)) {|weight, count| count[weight] += 1}
			.sort{|a,b| a[1]<=>b[1]}
		
		if weight_occ.length == 1 then
			# all descendents are balanced, the error is here.
			return pgm[:weight]-error
		else
			# one of the descendents is incorrect
			# weight_occ[1] is correct, weight_occ[0] is in error.
			# weight_occ[x][0] holds the weights
			error = weight_occ[0][0] - weight_occ[1][0]
			error_pgm = supported_weight_list.select{|sup| sup[1] == weight_occ[0][0]}[0][0]

			return unbalanced(programs, error_pgm, error)
		end
	end
end
