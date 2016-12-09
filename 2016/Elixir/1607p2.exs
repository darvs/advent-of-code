defmodule AoC1607p2 do

  def run(file) do

    IO.puts "Starting time: " <> DateTime.to_string(DateTime.utc_now)

    File.stream!(file, [:utf8])
      |> Enum.map(&(String.strip/1))
      |> Enum.map(&(String.split(&1,~r/[\[\]]/)))
      |> Enum.map(fn x -> [
                            Enum.take_every(x, 2)     |> Enum.join("."),
                            Enum.take_every(tl(x), 2) |> Enum.join(".")
                           ]
                             |> IO.inspect
                             |> Enum.map(fn z ->
                                  Enum.filter(Regex.scan(~r/(?=([a-z])([a-z])\1)/, z), fn y -> Enum.at(y,1) != Enum.at(y,2) end)
                                    |> IO.inspect
                                    |> Enum.map(fn w -> tl(w) end)
                                    |> Enum.map(fn w -> {hd(w), hd(tl(w))} end)
                                    |> Enum.uniq
                                end)
                        end)

      |> Enum.map(fn a -> {hd(a), hd(tl(a))} end)
      |> Enum.filter(fn {b,c} -> Enum.any?(b, fn b1 ->
                                    Enum.any?(c, fn c1 ->
                                      ((elem(c1,0) == elem(b1,1)) && (elem(c1,1) == elem(b1,0))) end)
                                    end)
                              end)
      |> IO.inspect
      |> Enum.count
      |> IO.inspect

    IO.puts "Ending time: " <> DateTime.to_string(DateTime.utc_now)
  end
end


#AoC1607p2.run("1607.test2.input")
AoC1607p2.run("1607.real.input")
