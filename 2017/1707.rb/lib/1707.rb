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

	supported = pgm[:supported]
	supported_weight_list = supported.empty? ? [{leaf: 0}] : supported.map{|sup| {sup => weight(programs, sup)}}
	weights = supported_weight_list.map{|sup| sup.values[0]}
	weight_count = Hash.new 0
	weights.map{|w| weight_count[w] += 1}

	correct = 0
	error = 0

	weight_count.map{|x| if x[1] > 1 then correct=x[0] else error=x[0] end}

	puts "LIST:: #{supported_weight_list} WEIGHTS:: #{weights} WEIGHT_COUNT:: #{weight_count} UNIQ:: #{weight_count.keys.uniq} CORRECT:: #{correct} ERROR: #{error}"

	supported_weight_list.each{|sup| puts "SUP: #{sup}"; if error != 0 and sup.values[0] == error then puts "SUP.KEYS[0]:: #{sup.keys[0]}"; programs[sup.keys[0]][:balanced] = programs[sup.keys[0]][:weight] + (correct - error) end} 
	
	#pgm[:balanced] = if error != 0 then pgm[:weight] + (correct - error) else 0 end
	supported_weight = weights.reduce(:+) 
	pgm[:total_weight] = pgm[:weight] + supported_weight

	return pgm[:total_weight]
end

def unbalanced(programs)
	puts "UNBALANCED:: #{programs.select {|k,v| v.has_key?(:balanced)}}"
end
