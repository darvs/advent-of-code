defmodule AoC1618 do

# def its_a_trap("^^."), do: "^"
# def its_a_trap(".^^"), do: "^"
# def its_a_trap("^.."), do: "^"
# def its_a_trap("..^"), do: "^"
# def its_a_trap(_), do: "."

def process_line(line) do
  "." <> line <> "."
    |> String.graphemes
    |> Enum.chunk(3,1)
    |> Enum.reduce([], fn ([a,_,c],acc) -> [(if a != c, do: "^", else: ".")] ++ acc end)
    |> Enum.reverse
    |> Enum.join
end


def build(line, 0, acc), do: Enum.reverse([line] ++ acc)

def build(line, n, acc) do
  process_line(line)
    |> build(n-1, [line] ++ acc)
end

def build(line, n) do
  build(line, n-1, [])
end

def count_safe(arr) do
  Enum.join(arr)
    |> String.graphemes
    |> Enum.count(fn x -> x == "." end)

end

def run(line, n) do
  build(line, n) |> count_safe
end


end
