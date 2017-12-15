class Generator
  attr_accessor :value
  attr_accessor :value_needs_to_be_a_multiple_of

  def initialize(starting_value, factor)
    @value = starting_value
    @factor = factor
    @value_needs_to_be_a_multiple_of = 1
  end

  def step
    loop do
      @value = (@value * @factor) % 2_147_483_647
      break if (@value % value_needs_to_be_a_multiple_of).zero?
    end
  end

  def match_value
    @value & 0xFFFF
  end
end
