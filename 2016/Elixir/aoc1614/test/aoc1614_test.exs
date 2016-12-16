defmodule AoC1614Test do
  use ExUnit.Case
  doctest AoC1614

  test "MD5" do
    IO.puts("------------------")
    IO.puts(" MD5")
    IO.puts("------------------")
    assert AoC1614.md5(816, "abc") == [816, "e", "e"]
  end

  test "Example" do
    IO.puts("------------------")
    IO.puts(" Example")
    IO.puts("------------------")
    assert AoC1614.run("abc") == 22728
  end

  test "Puzzle #1" do
    IO.puts("------------------")
    IO.puts(" Puzzle #1")
    IO.puts("------------------")
    assert AoC1614.run("qzyelonm") == 15168
  end

end
