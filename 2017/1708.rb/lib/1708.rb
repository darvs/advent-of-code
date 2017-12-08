$cond = {
	"<"  => lambda{|v1, v2| v1<v2},
	"<=" => lambda{|v1, v2| v1<=v2},
	"==" => lambda{|v1, v2| v1==v2},
	"!=" => lambda{|v1, v2| v1!=v2},
	">=" => lambda{|v1, v2| v1>=v2},
	">"  => lambda{|v1, v2| v1>v2}
}

$op = {
	"inc" => lambda{|registers, reg, val| registers[reg] += val},
	"dec" => lambda{|registers, reg, val| registers[reg] -= val},
}

def parse(str)
	regexp = /(?<op_reg>[a-z]+?) (?<op>[a-z]+?) (?<op_val>-?[0-9]+?) if (?<cond_reg>[a-z]+?) (?<cond>.+?) (?<cond_val>-?[0-9]+)/
	return str.scan(regexp).map{|match|
		Hash[regexp.names.zip(match)]
	}.first
end

def exec(registers, ins)
	if $cond[ins["cond"]][registers[ins["cond_reg"]], ins["cond_val"].to_i] then
		$op[ins["op"]][registers, ins["op_reg"], ins["op_val"].to_i]
	end
	return registers
end

def exec_file(filename)
	registers = Hash.new 0
	max = 0

	File.open(File.join('data', filename))
		.map {|str| parse(str)}
		.each {|ins|
			registers = exec(registers, ins)
			max = [max, largest(registers)].max
		}

	return registers, max
end


def largest(registers)
	return registers.values.sort.reverse.first
end
