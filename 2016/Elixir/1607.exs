defmodule AoC1607 do

  def run(file) do

    IO.puts "Starting time: " <> DateTime.to_string(DateTime.utc_now)

    File.stream!(file, [:utf8])
      |> Enum.map(&(String.strip/1))
      |> IO.inspect
      |> Enum.filter(fn x -> Enum.count(Enum.filter(Regex.scan(~r/\[[^\]]*(?<a>[a-z])(?<b>[a-z])\k<b>\k<a>[^\]]*\]/, x), fn y -> Enum.at(y,1) != Enum.at(y,2) end)) == 0 end)
      |> Enum.filter(fn x -> Enum.count(Enum.filter(Regex.scan(~r/(?<a>[a-z])(?<b>[a-z])\k<b>\k<a>/, x), fn y -> Enum.at(y,1) != Enum.at(y,2) end)) > 0 end)
      |> IO.inspect
      |> Enum.count
      |> IO.puts

    IO.puts "Ending time: " <> DateTime.to_string(DateTime.utc_now)



  end
end



#AoC1607.run("1607.test.input")

AoC1607.run("1607.real.input")
