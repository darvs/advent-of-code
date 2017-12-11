def set_steps(str)
	str.split(",").map{|d| d.to_sym}
end

def load_steps(filename)
	set_steps(File.read(File.join("data", filename)).strip)
end

def optimize(path)
	optimizations = [
		[:ne, :nw, :n],
		[:ne, :s, :se],
		[:se, :n, :ne],
		[:se, :sw, :s],
		[:s, :ne, :se],
		[:s, :nw, :sw],
		[:sw, :se, :s],
		[:sw, :n, :nw],
		[:nw, :s, :sw],
		[:nw, :ne, :n],
		[:ne, :sw, nil],
		[:e, :w, nil],
		[:se, :nw, nil],
		[:s, :n, nil]
	]

	steps = Hash.new 0
	distance = 0
	farthest = 0

	path.each{|step|
		steps[step] += 1

		loop do
			prev_distance = distance

			optimizations.each{|a, b, ab|
				if (qty = [steps[a], steps[b]].min) > 0 then
					steps[a] -= qty
					steps[b] -= qty
					unless ab.nil? then
						steps[ab] += qty
					end
				end
			}
			distance = steps.map{|k,v| v}.reduce(:+)
			farthest = [farthest, distance].max

			break if distance == prev_distance
		end
	}

	return distance, farthest
end
