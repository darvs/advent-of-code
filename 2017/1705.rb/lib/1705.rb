def read(code) 
	return code.split(/\s/).reject{|s| s == '\"'}.map{|s| s.to_i}
end

def one_step(pc, code)
	memory = read(code)

	_, pc2, memory = run(memory, pc, 1)

	result = memory.map{|i| i.to_s}.join(" ")
	
	return pc2, result
end

def load(code, jumps = :normal) 
	memory = read(code)

	steps, _, _ = run(memory, 0, -1, jumps)

	return steps
end

def read_file(filename)
	File.read(File.join("data",filename)).split(/\s/).join(" ")
end

def run(memory, pc, step_limit = -1, jumps = :normal)
	steps = 0

	loop do 
		jmp = memory[pc]
		if jumps == :stranger and memory[pc] >= 3 then
			memory[pc] -= 1
		else
			memory[pc] += 1
		end
		pc = pc + jmp
		steps += 1

		break if (steps == step_limit) or (pc < 0) or (pc >= memory.length)
	end

	return steps, pc, memory
end
