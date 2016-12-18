defmodule AoC1618 do



def its_a_trap("^^."), do: "^"
def its_a_trap(".^^"), do: "^"
def its_a_trap("^.."), do: "^"
def its_a_trap("..^"), do: "^"
def its_a_trap(_), do: "."

def process_line(line, acc) do
  if String.length(line) == 2 do
    acc
  else
    process_line(String.slice(line, 1..-1), acc <> its_a_trap(String.slice(line, 0..2)))
  end
end

def process_line(line) do
  process_line("." <> line <> ".", "")
end

def build(_, 0, acc), do: acc

def build(line, n, acc) do
  new_line = process_line(line)
  build(new_line, n-1, acc ++ [new_line])
end

def build(line, n) do
  build(line, n-1, [line])
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
