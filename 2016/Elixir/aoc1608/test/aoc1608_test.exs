defmodule AoC1608Test do
  use ExUnit.Case
  doctest AoC1608

  test "Create Screen" do
    assert  AoC1608.create_screen(7, 3)
              |> AoC1608.repr

        == [".......",
            ".......",
            "......."]
  end

  test "Rect" do
    assert  AoC1608.create_screen(7, 3)
              |> AoC1608.rect(3, 2)
              |> AoC1608.repr

        == ["###....",
            "###....",
            "......."]

  end

  test "Rotate Column" do
    assert  AoC1608.create_screen(7, 3)
              |> AoC1608.rect(3, 2)
              |> AoC1608.rotate_column(1, 1)
              |> AoC1608.repr

        == ["#.#....",
            "###....",
            ".#....."]

  end

  test "Rotate Row" do
    assert  AoC1608.create_screen(7, 3)
              |> AoC1608.rect(3, 2)
              |> AoC1608.rotate_column(1, 1)
              |> AoC1608.rotate_row(0, 4)
              |> AoC1608.repr

        == ["....#.#",
            "###....",
            ".#....."]

  end

  test "Rotate Column #2" do
    assert  AoC1608.create_screen(7, 3)
              |> AoC1608.rect(3, 2)
              |> AoC1608.rotate_column(1, 1)
              |> AoC1608.rotate_row(0, 4)
              |> AoC1608.rotate_column(1, 1)
              |> AoC1608.repr

        == [".#..#.#",
            "#.#....",
            ".#....."]

  end

  test "Test" do
    assert  AoC1608.run(7, 3, "test/input/1608.test.input")
              |> AoC1608.repr

      == [".#..#.#",
          "#.#....",
          ".#....."]
  end

  test "Count" do
    assert  AoC1608.run(7, 3, "test/input/1608.test.input")
              |> AoC1608.repr
              |> AoC1608.count

      == 6

  end

  test "Puzzle #1" do
    assert  AoC1608.run(50, 6, "test/input/1608.real.input")
              |> AoC1608.repr
              |> AoC1608.count
      == 119
  end

  test "Puzzle #2" do
    IO.puts("")
    AoC1608.run(50, 6, "test/input/1608.real.input")
      |> AoC1608.print
  end

end
