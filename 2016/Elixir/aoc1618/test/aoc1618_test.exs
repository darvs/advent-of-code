defmodule AoC1618Test do
  use ExUnit.Case
  import AoC1618
  doctest AoC1618

  test "Process line #1" do
    assert process_line("..^^.") == ".^^^^"
  end

  test "Process line #2" do
    assert process_line(".^^^^") == "^^..^"
  end

  test "Process 3 lines" do
    assert build("..^^.", 3) ==

      [ "..^^.",
        ".^^^^",
        "^^..^" ]
  end

  test "Process 10 lines" do
    assert build(".^^.^.^^^^", 10) ==

      [ ".^^.^.^^^^",
        "^^^...^..^",
        "^.^^.^.^^.",
        "..^^...^^^",
        ".^^^^.^^.^",
        "^^..^.^^..",
        "^^^^..^^^.",
        "^..^^^^.^^",
        ".^^^..^.^^",
        "^^.^^^..^^" ]


  end

  test "Count Safe Tiles" do
    assert run(".^^.^.^^^^", 10) == 38
  end

  test "Puzzle #1" do
    assert run(".^^..^...^..^^.^^^.^^^.^^^^^^.^.^^^^.^^.^^^^^^.^...^......^...^^^..^^^.....^^^^^^^^^....^^...^^^^..^", 40) == 2005
  end


  # First attempt at test Puzzle #2 took (4903357.6ms), that's 1 hour, 21 minutes and 43 seconds.

  test "Puzzle #2" do
    assert run(".^^..^...^..^^.^^^.^^^.^^^^^^.^.^^^^.^^.^^^^^^.^...^......^...^^^..^^^.....^^^^^^^^^....^^...^^^^..^", 400000) == 20008491
  end


end
