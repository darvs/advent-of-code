class Hashf

	attr_accessor :pos, :skip_size

	def initialize(hash_len, start)
		@arr = Array(start..start+(hash_len-1))
		@pos = 0
		@skip_size = 0
		@lengths = []
		@offset_in_lenghts = 0
	end

	def set_input_lengths(str)
		@lengths = str.split(",").map{|len| len.to_i}
	end

	def step
		list = []

		pinch_len = @lengths[@offset_in_lenghts]
		#puts "OFFSET: #{@offset_in_lenghts} LENGTHS:: #{@lengths} PINCH_LEN:: #{pinch_len}"

		for i in 0..(pinch_len-1)
			list << @arr[(@pos + i) % @arr.length]
		end

		list.reverse!

		for i in 0..(pinch_len-1)
			@arr[(@pos + i) % @arr.length] = list[i]
		end

		@pos = (@pos + pinch_len + @skip_size) % @arr.length

		@skip_size += 1
		@offset_in_lenghts += 1
	end

	def arr
		return @arr.join(" ")
	end

	def mult
		return @arr[0] * @arr[1]
	end

	def read_input_lengths(filename)
		set_input_lengths(File.read(File.join("data", filename)))
	end

	def set_binary_input_lengths(str)
		@lengths = []
		str.each_byte{|byte| @lengths << byte}
		@lengths << [17, 31, 73, 47, 23]
		@lengths.flatten!
	end

	def read_binary_input_lengths(filename)
		# the strip is really important here otherwise we might get a spurious ending 0xA
		set_binary_input_lengths(File.read(File.join("data", filename), mode: "rb").strip)
	end

	def calc(rounds = 1)
		for _ in 1..rounds
			@offset_in_lenghts = 0
			while @offset_in_lenghts < @lengths.length
				step
			end
		end
	end

	def hash
		str = ""
		for y in 0..15
			dense = @arr[y*16]
			for x in 1..15
				dense = dense ^ @arr[y*16+x]
			end
			str += "%02x" % dense
		end
		return str
	end
end
