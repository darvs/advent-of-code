defmodule AoC1620 do


def merge_ranges(ranges) when length(ranges) <= 1, do: ranges

def merge_ranges(ranges) do
  [{begin1, end1}, {begin2, end2}|_] = ranges

  cond do

    # There is a gap
    # <b1..e1> ... [b2..e2]
    begin2 > end1+1 -> [{begin1, end1}] ++ merge_ranges(ranges |> Enum.drop(1))

    # The second one was already included
    # <b1..[b2..e2]..e1>
    end2 < end1 -> merge_ranges([{begin1, end1}] ++ (ranges |> Enum.drop(2)))

    # Merge overlapping ranges
    # <b1.. .... . ..e1> ...]
    # <.... [b2 ... ....  e2]
    true -> merge_ranges([{begin1, end2}] ++ (ranges |> Enum.drop(2)))

  end


end


def find_first_gap([{_, end1}, {begin2, _}|_]) do
    [end1+1, begin2-1]
end


def measure_gaps(ranges) do
  Enum.chunk(ranges,2,1)
    |> Enum.map(fn [{_, end1}, {begin2, _}] -> begin2 - end1 - 1 end)
    |> Enum.sum
end

def solve_puzzle(lines, :puzzle1) do

  lines
    |> find_first_gap
    |> hd

end

def solve_puzzle(lines, :puzzle2) do

  lines
    |> measure_gaps

end

def run(file, puzzle \\ :puzzle1) do
  File.stream!(file, [:utf8])
    |> Enum.map(&(String.strip/1))
    |> Enum.map(fn x -> Regex.run(~r/([0-9]+)-([0-9]+)/, x) end)
    |> Enum.map(fn [_, min, max] -> {String.to_integer(min), String.to_integer(max)} end)
    |> Enum.sort_by(fn {min, _} -> min end)
    |> merge_ranges
    |> solve_puzzle(puzzle)

end


end
