defmodule AoC1617Test do
  use ExUnit.Case
  import AoC1617
  doctest AoC1617

  test "MD5 Compute" do
    assert md5_compute("hijkl", "") ==  ["U", "D", "L"]
  end

  test "Issues" do
    assert issues("", {0,0}, "hijkl") ==  ["D"]
  end

  test "Test" do
    assert run("hijkl") == nil
  end

  test "Easter Bunny #1", do: assert run("ihgpwlah") == "DDRRRD"
  test "Easter Bunny #2", do: assert run("kglvqrro") == "DDUDRLRRUDRD"
  test "Easter Bunny #3", do: assert run("ulqzkmiv") == "DRURDRUDDLLDLUURRDULRLDUUDDDRR"

  test "Puzzle #1" do
    assert run("qljzarfv") == "DRLRDDURDR"
  end

  test "Puzzle #2" do
    assert run("qljzarfv", :puzzle2) == 500
  end
end
