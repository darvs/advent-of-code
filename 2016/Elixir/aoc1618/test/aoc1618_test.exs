defmodule AoC1618Test do
  use ExUnit.Case
  import AoC1618
  doctest AoC1618

  test "Process line #1" do
    assert process_line_debug("..^^.") == ".^^^^"
  end

  test "Process line #2" do
    assert process_line_debug(".^^^^") == "^^..^"
  end

  test "Process 3 lines" do
    assert build_debug("..^^.", 3) ==

      [ "..^^.",
        ".^^^^",
        "^^..^" ]
  end

  test "Process 10 lines" do
    assert build_debug(".^^.^.^^^^", 10) ==

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

  # First attempt at test Puzzle #1 took 41.4ms

  test "Puzzle #1" do
    assert run(".^^..^...^..^^.^^^.^^^.^^^^^^.^.^^^^.^^.^^^^^^.^...^......^...^^^..^^^.....^^^^^^^^^....^^...^^^^..^", 40) == 2005
  end


  # Benchmarking tests

  test "Puzzle #2 : 1000" do
    assert run(".^^..^...^..^^.^^^.^^^.^^^^^^.^.^^^^.^^.^^^^^^.^...^......^...^^^..^^^.....^^^^^^^^^....^^...^^^^..^", 1000) == 49898
  end

  test "Puzzle #2 : 10000" do
    assert run(".^^..^...^..^^.^^^.^^^.^^^^^^.^.^^^^.^^.^^^^^^.^...^......^...^^^..^^^.....^^^^^^^^^....^^...^^^^..^", 10000) == 500022
  end

  test "Puzzle #2 : 100000" do
    assert run(".^^..^...^..^^.^^^.^^^.^^^^^^.^.^^^^.^^.^^^^^^.^...^......^...^^^..^^^.....^^^^^^^^^....^^...^^^^..^", 100000) == 4998606
  end

  # First attempt at test Puzzle #2 took 4903357.6ms, that's 1 hour, 21 minutes and 43 seconds.
  # Second attempt at test Puzzle #2 took 127601.4ms, that's 2 minutes and 8 seconds.
  # Third attempt at test Puzzle #2 took 32220.6ms, that's 32 seconds.

  @tag slow: true
  test "Puzzle #2" do
    assert run(".^^..^...^..^^.^^^.^^^.^^^^^^.^.^^^^.^^.^^^^^^.^...^......^...^^^..^^^.....^^^^^^^^^....^^...^^^^..^", 400000) == 20008491
  end


end
