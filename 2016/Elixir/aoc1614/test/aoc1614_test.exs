defmodule AoC1614Test do
  use ExUnit.Case
  doctest AoC1614

  test "MD5 Compute" do
    assert String.contains?(AoC1614.md5_compute("abc18", 0), "cc38887a5")
  end

  test "MD5 Stretching" do
    assert AoC1614.md5_compute("abc0", 2016) == "a107ff634856bb300138cac6568c0f24"
  end


  test "MD5 Parse" do
    assert AoC1614.md5_parse(816, "abc", 0) == [816, "e", "e"]
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

  test "Puzzle #2" do
    IO.puts("------------------")
    IO.puts(" Puzzle #2")
    IO.puts("------------------")
    AoC1614.run("qzyelonm", 2016) == 20864
  end
end
