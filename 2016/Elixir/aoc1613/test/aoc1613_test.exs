defmodule AoC1613Test do
  use ExUnit.Case


  doctest AoC1613

  test "Power: Now you're playing with --" do
    assert AoC1613.pow(2,8) == 256
  end

  test "Binary: Either you understand it or you don''t" do
    assert AoC1613.to_binary(42) == "101010"
  end

  test "Odd number of ones" do
    assert AoC1613.number_of_ones(42) == 3
  end

  test "Even number of ones" do
    assert AoC1613.number_of_ones(3) == 2
  end

  test "Run with test data" do
     AoC1613.run(10, {7,4})
  end

  @tag timeout: 120000
  test "Run for realsies" do
     AoC1613.run(1358, {31,39})
  end

end
