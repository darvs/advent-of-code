defmodule AoC1615Test do
  use ExUnit.Case
  doctest AoC1615

  test "Example" do
    IO.puts("------------------")
    IO.puts(" Example")
    IO.puts("------------------")
    AoC1615.run("test/input/1615.test.input")
  end
  test "Puzzle #1" do
    IO.puts("------------------")
    IO.puts(" Puzzle #1")
    IO.puts("------------------")
    AoC1615.run("test/input/1615.real.input")
  end
  test "Puzzle #2" do
    IO.puts("------------------")
    IO.puts(" Puzzle #2")
    IO.puts("------------------")
    AoC1615.run("test/input/1615.real2.input")
  end
end
