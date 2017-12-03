class Location

	@@headings = [[1,0], [0,1], [-1,0], [0,-1]]
	@@diagonals = [[1,1], [-1,1], [-1,-1], [1,-1]]

	@@instructions = [:increment_and_turn, :turn]

	def initialize(square, limit = -1)
		@x = 0
		@y = 0
		@distance = square-1
		@limit = limit
		@counter = 0 
		@cur_heading = 0
		@cur_segment_len = 1
		@cur_distance_in_segment = 0
		@cur_instruction = 0

		# default accumulator for first square
		@squares = Hash.new(0)
		@squares[[0,0]] = 1
	end

	def walk
		val = 1 # default for first node

		while ((@distance == -1) or (@counter < @distance)) and ((@limit == -1) or (val <= @limit)) do

				# Take one step
				@cur_distance_in_segment += 1 
				#puts "current_heading : #{@@headings[@cur_heading]}"
				@x += @@headings[@cur_heading].first
				@y += @@headings[@cur_heading].drop(1).first

				val = 0
				# Calaculate value
				for head in 0..(@@headings.length-1) do
						new_val = @squares[[@x + @@headings[head].first, @y + @@headings[head].drop(1).first]]
						val += new_val
						puts ("@cnt: #{@counter},  head: #{@@headings[head].first}, #{@@headings[head].drop(1).first} val:#{val}") 
				end
				for diag in 0..(@@diagonals.length-1) do
						new_val = @squares[[@x + @@diagonals[diag].first, @y + @@diagonals[diag].drop(1).first]]
						val += new_val
						puts ("@cnt: #{@counter}, diag: #{@@diagonals[diag].first}, #{@@diagonals[diag].drop(1).first} val:#{val}") 
				end
				@squares[[@x, @y]] = val

				# We have reached the end of this segment
				if @cur_distance_in_segment == @cur_segment_len then
						# Time to read a new instruction
						@cur_instruction += 1

						if @@instructions[(@cur_instruction % @@instructions.length)] == :increment_and_turn then
								@cur_segment_len += 1
						end

						# New segment
						@cur_heading += 1
						@cur_heading = @cur_heading % @@headings.length
						@cur_distance_in_segment = 0

				end
				@counter += 1
		end
		
		return @x.abs + @y.abs, val, @counter+1
    end
end
