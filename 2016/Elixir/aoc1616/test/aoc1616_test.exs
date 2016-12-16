defmodule AoC1616Test do
  use ExUnit.Case
  doctest AoC1616

  test "Invert" do
    assert AoC1616.invert("10000") == "11110"
  end

  test "Dragon" do
    assert AoC1616.dragon("10000", 20) == "10000011110010000111"
  end

  test "Checksum" do
    assert AoC1616.checksum("10000011110010000111") == "01100"
  end

  test "Test" do
    assert AoC1616.run("10000", 20) == "01100"
  end

  test "Puzzle #1" do
    assert AoC1616.run("01000100010010111", 272) == "10010010110011010"
  end

  test "Puzzle #2" do
    assert AoC1616.run("01000100010010111", 35651584) == "01010100101011100"
  end

end
