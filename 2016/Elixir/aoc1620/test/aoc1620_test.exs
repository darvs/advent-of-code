defmodule AoC1620Test do
  use ExUnit.Case
  import AoC1620
  doctest AoC1620

  test "Puzzle #1" do
    assert run("test/input/1620.real.input") == 31053880
  end

  test "Puzzle #2" do
    assert run("test/input/1620.real.input", :puzzle2) == 117
  end
end
