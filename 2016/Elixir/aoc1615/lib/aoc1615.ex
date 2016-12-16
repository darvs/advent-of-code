defmodule AoC1615 do

  def test(list, disc, time) do

    # IO.inspect([list, disc, time])

    if disc > length(list) do
      time

    else
      [offset, num_pos, initial] = Enum.at(list, disc-1)

      if rem(initial + time + offset, num_pos) == 0 do
        test(list, disc+1, time)

      else
        test(list, 1, time+1)
      end

    end

  end

  def run(file) do

    IO.puts "Starting time: " <> DateTime.to_string(DateTime.utc_now)

    answer =  File.stream!(file, [:utf8])
                |> Enum.map(&(String.strip/1))
                |> Enum.map(fn str -> Regex.run(~r/Disc #([0-9]+) has ([0-9]+) positions; at time=0, it is at position ([0-9]+)./, str) end)
                |> Enum.map(fn regsult -> tl(regsult) end)
                |> Enum.map(&(Enum.map(&1, fn convert -> String.to_integer(convert) end)))
                |> test(1, 0)

    IO.puts("------------------")
    IO.puts(" Answer #1 : #{answer} ")
    IO.puts("------------------")


    IO.puts "Ending time: " <> DateTime.to_string(DateTime.utc_now)

  end

end
