def d01 (str, offset_fn)
	acc = 0
	for i in 0..str.length-1 do
		if str[i] == str[(i + offset_fn[str]) % str.length] then
			acc += str[i].to_i
		end
	end
	#puts "Input: #{str}"
	#puts "  Total: #{acc.to_s}"

	acc
end

def d01p1(str)
		d01(str, lambda {|s| 1})
end

def d01p2(str)
		d01(str, lambda {|s| s.length/2})
end

# vim: ts=4
