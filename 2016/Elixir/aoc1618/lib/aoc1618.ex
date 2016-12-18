defmodule AoC1618 do

def process_line(line) do
  line
    |> Enum.reverse
    |> (fn line -> ["."] ++ line end).()
    |> Enum.reverse
    |> (fn line -> ["."] ++ line end).()
    |> Enum.chunk(3,1)
    |> Enum.reduce([], fn ([a,_,c],acc) -> [(if a != c, do: "^", else: ".")] ++ acc end)
    |> Enum.reverse
end

def process_line_debug(line) do
  process_line(String.graphemes(line)) |> Enum.join
end

def build(line, 0, acc), do: Enum.reverse([line] ++ acc)

def build(line, n, acc) do
  process_line(line)
    |> build(n-1, [line] ++ acc)
end

def build(line, n) do
  String.graphemes(line) |>
    build(n-1, [])
end

def build_debug(line, n) do
  build(line, n)
    |> Enum.map(&Enum.join/1)
end

def count_safe(arr) do
  List.flatten(arr)
    |> Enum.count(fn x -> x == "." end)

end

def run(line, n) do
  build(line, n) |> count_safe
end


end
