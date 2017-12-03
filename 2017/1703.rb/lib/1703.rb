class Location

	@@headings = [[1,0], [0,1], [-1,0], [0,-1]]
	@@diagonals = [[1,1], [-1,1], [-1,-1], [1,-1]]

	@@instructions = [:increment_and_turn, :turn]

	def initialize(square, limit = -1)
		@pos = [0,0]
		@distance = square-1
		@counter = 0 
		@limit = limit
		@cur_heading = 0
		@cur_segment_len = 1
		@cur_distance_in_segment = 0
		@cur_instruction = 0

		# default accumulator for first square
		@val = Hash.new(0)
		@val[@pos] = 1
	end

	def walk(context = :normal)

		while ((@distance == -1) or (@counter < @distance)) and ((@limit == -1) or (@val[@pos] <= @limit)) do

				# Take one step
				@cur_distance_in_segment += 1 
				
				@pos = @pos.zip(@@headings[@cur_heading]).map{|x| x.reduce(:+)}

				if context == :stress_test then

						@val[@pos] = (@@headings + @@diagonals).map{|direction| @val[@pos.zip(direction).map{|x| x.reduce(:+)}]}.reduce(:+)

				end

				# We have reached the end of this segment
				if @cur_distance_in_segment == @cur_segment_len then

						# Time to read a new instruction
						@cur_instruction = (@cur_instruction + 1) % @@instructions.length

						if @@instructions[@cur_instruction] == :increment_and_turn then
								# We (increment) for the next segment, (turn) will be done by default
								@cur_segment_len += 1
						end

						# New segment (turn)
						@cur_heading = (@cur_heading + 1) % @@headings.length
						@cur_distance_in_segment = 0

				end
				@counter += 1
		end
	
		manhattan_distance = @pos.first.abs + @pos.drop(1).first.abs
		stress_test_value = @val[@pos]

		return manhattan_distance, stress_test_value
	end
end
