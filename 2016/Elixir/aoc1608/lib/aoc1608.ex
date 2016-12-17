defmodule AoC1608 do

def create_dimension(n, v) do
  0..n-1
    |> Enum.zip(List.duplicate(v, n))
    |> Enum.into(%{})
end

def create_screen(x, y) do
  create_dimension(x, create_dimension(y, 0))
end

def set(screen, {x,y}, val) do
  put_in(screen[x][y], val)
end

def set(screen, [], _) do
  screen
end

def set(screen, list, val) when is_list(list) and is_list(val) do
  [first      | rest    ] = list
  [first_val  | rest_val] = val

  set(screen, first, first_val)
    |> set(rest, rest_val)
end

def set(screen, list, val) when is_list(list) do
  [first | rest] = list
  set(screen, first, val)
    |> set(rest, val)
end

def rect(screen, x, y) do
  points = for i <- 0..x-1, j <- 0..y-1, do: {i,j}

  set(screen, points, 1)
end

def repr(screen) do
  x = Enum.count(screen)
  y = Enum.count(screen[0])

  for j <- 0..y-1 do
    for i <- 0..x-1, into: "" do
      if screen[i][j] == 1, do: "#", else: "."
    end
  end
end

def get_column(x, screen) do
  y = Enum.count(screen[0])

  for j <- 0..y-1 do
    {x,j}
  end
end

def get_row(y, screen) do
  x = Enum.count(screen)

  for i <- 0..x-1 do
    {i,y}
  end
end


def get_values(list, screen) do

  for {x,y} <- list do
    screen[x][y]
  end
end

def rotate_list(list, 0) do
  list
end

def rotate_list(list, offset) do
  [last | reversed_top] = list |> Enum.reverse
  top = reversed_top |> Enum.reverse

  rotate_list([last] ++ top, offset-1)
end

def rotate(screen, coords, delta) do
  val = get_values(coords, screen)

  rot_val = rotate_list(val, delta)

  set(screen, coords, rot_val)
end

def rotate_column(screen, x, dy) do
  rotate(screen, get_column(x, screen), dy)
end

def rotate_row(screen, y, dx) do
  rotate(screen, get_row(y, screen), dx)
end

def print(screen) do
  for line <- repr(screen) do
    IO.puts(line)
  end
end

def to_i(s) do
  String.to_integer(s)
end

def exec(screen, "rotate", "row", line) do
  re = Regex.named_captures(~r/rotate row y=(?<y>[0-9]+) by (?<offset>[0-9]+)/, line)
  rotate_row(screen,  re["y"]       |> to_i,
                      re["offset"]  |> to_i )
end

def exec(screen, "rotate", "column", line) do
  re = Regex.named_captures(~r/rotate column x=(?<x>[0-9]+) by (?<offset>[0-9]+)/, line)
  rotate_column(screen, re["x"]       |> to_i,
                        re["offset"]  |> to_i )
end


def exec(screen, "rotate", line) do
    [_,axis | _] = String.split(line)
    exec(screen, "rotate", axis, line)
end

def exec(screen, "rect", line) do
    re = Regex.named_captures(~r/rect (?<x>[0-9]+)x(?<y>[0-9]+)/, line)
    rect(screen,  re["x"] |> to_i,
                  re["y"] |> to_i )
end

def exec(screen, line) when is_binary(line) do
  [command | _] = String.split(line)
  exec(screen, command, line)
end

def exec(screen, []) do
  screen
end


def exec(screen, lines) when is_list(lines) do
  [first | rest] = lines

  exec(screen, first) |> exec(rest)
end

def count(repr) do
  Enum.join(repr)
    |> String.graphemes
    |> Enum.count(fn x -> x == "#" end)
end

def run(x, y, file) do
  screen = create_screen(x, y)

  lines =  File.stream!(file, [:utf8])
              |> Enum.map(&(String.strip/1))

  exec(screen, lines)
end

end
