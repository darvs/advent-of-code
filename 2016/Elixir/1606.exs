defmodule AoC1606 do

  def run(file) do

    IO.puts "Starting time: " <> DateTime.to_string(DateTime.utc_now)

    File.stream!(file, [:utf8])
      |> Stream.map(&(String.strip/1))
      |> Stream.map(&(String.codepoints(&1)))
      |> Stream.flat_map(&(Enum.zip(0..Enum.count(&1), &1)))
      |> Enum.take_every(1)
      |> Enum.group_by(&(elem(&1, 0)), &(elem(&1, 1)))
      |> Map.to_list
      |> IO.inspect
      |> Enum.map(fn {_,v} -> Enum.map(Enum.dedup(Enum.sort(v)), fn(x) -> {x, Enum.count(v, fn(y) -> y == x end)} end) end)
      |> Enum.map(&(elem(Enum.max_by(&1, fn(x) -> elem(x,1) end),0)))
      |> Enum.join
      |> IO.inspect


    IO.puts "Ending time: " <> DateTime.to_string(DateTime.utc_now)

  end
end


# AoC1606.run("1606.test.input")
AoC1606.run("1606.real.input")
