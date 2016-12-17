defmodule AoC1617 do

def md5_compute(passcode, path) do
  String.downcase(Base.encode16(:crypto.hash(:md5, passcode <> path)))
    |> String.slice(0..3)
    |> String.graphemes
    |> Enum.map(fn x -> if Regex.match?(~r/[b-f]/, x), do: true, else: false end)
    |> Enum.zip(["U", "D", "L", "R"])
    |> Enum.reduce([], fn {b, dir}, acc -> if b, do: acc ++ [dir], else: acc end)
end

def issue?({0,_}, "L"), do: false
def issue?({3,_}, "R"), do: false
def issue?({_,0}, "U"), do: false
def issue?({_,3}, "D"), do: false
def issue?({_,_}, _),   do: true


def issues(path, {x,y}, passcode) do
  md5_compute(passcode, path) |> Enum.filter(fn dir -> issue?({x,y}, dir) == true end)
end

def dest({x,y}, "L"), do: {x-1, y}
def dest({x,y}, "R"), do: {x+1, y}
def dest({x,y}, "U"), do: {x, y-1}
def dest({x,y}, "D"), do: {x, y+1}

def search(path, {3,3}, _) do
  [{{3,3}, path}]
end

def search(path, {x,y}, passcode) do
  exits = issues(path, {x,y}, passcode)

  if exits != [] do
    Enum.flat_map(exits, fn dir -> search(path <> dir, dest({x,y}, dir), passcode) end)
  else
    [{{x,y}, path}]
  end
end

def solve(results, :puzzle1) do
  List.first(results)
end

def solve(results, :puzzle2) do
  Enum.reverse(results)
    |> List.first
    |> String.length
end

def run(passcode, puzzle \\ :puzzle1) do

  search("", {0,0}, passcode)
    |> Enum.filter(fn {{x,y}, _} -> {x,y} == {3,3} end)
    |> Enum.sort(fn {_, path1}, {_, path2} -> String.length(path1) < String.length(path2) end)
    #|> Enum.map(fn {{x,y}, path} -> IO.puts("{#{x},#{y}}, #{path}") end)
    |> Enum.map(fn {_, path} -> path end)
    |> solve(puzzle)

end

end
