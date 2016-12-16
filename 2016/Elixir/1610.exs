defmodule AoC1610 do

  def addVal(map, _, _, nil) do
    map
  end

  def addVal(map, transfer_rules, id, val) do
    IO.inspect(["addVal", map, id, val])

    map2 = Map.update(map, id, [val], fn old -> [val|old] |> Enum.sort(&(String.to_integer(&1) < String.to_integer(&2))) end)

    Enum.reduce(map2, map2, fn {k,v},acc -> give(acc, transfer_rules, k, v) end)
  end

  def give(map, _, _, values) when length(values) < 2 do
      map
  end

  def give(map, transfer_rules, source_id, values) do
    IO.inspect(["give", map, source_id, values])

    if Map.get(transfer_rules, source_id) do
      [lo_val, hi_val] = values

      if values == ["17","61"] do
        IO.puts("***************************************************")
        IO.puts(" Puzzle #1 Answer is #{source_id}")
        IO.puts("***************************************************")
      end


      [dest_lo_id, dest_hi_id] = Map.get(transfer_rules, source_id)

      Map.delete(map, source_id)
        |> addVal(transfer_rules, dest_lo_id, lo_val)
        |> addVal(transfer_rules, dest_hi_id, hi_val)

    else
      map
    end

  end

  def run(file) do

    IO.puts "Starting time: " <> DateTime.to_string(DateTime.utc_now)

    {cmd_value, cmd_transfer} = File.stream!(file, [:utf8])
                                  |> Enum.map(&(String.strip/1))
                                  |> Enum.partition(fn(x) -> Regex.match?(~r/^value/, x) end)

    IO.inspect(["Value    Commands:", cmd_value])
    IO.inspect(["Transfer Commands:", cmd_transfer])

    transfer_rules =  Enum.map(cmd_transfer, fn x -> tl(Regex.run(~r/(.+) (.+) gives low to (.+) (.+) and high to (.+) (.+)/, x)) end)
                        |> Enum.reduce(%{}, fn [a,b,c,d,e,f], map -> Map.put(map, Enum.join([a,b], "-"), [Enum.join([c,d], "-"), Enum.join([e,f], "-")]) end)

    IO.inspect(["Transfer Rules:", transfer_rules])

    final_values = Enum.map(cmd_value, fn x -> Regex.run(~r/value (.+) goes to bot (.+)/, x) end)
      |> Enum.map(fn [_|t] -> {Enum.join(["bot", hd(tl(t))], "-"), hd(t)} end)
      |> Enum.reduce(%{}, fn {bot, val}, map -> addVal(map, transfer_rules, bot, val) end)


    IO.inspect(["Final Values:", final_values])

    # For Puzzle #2 : What do you get when you multiply a value
    # each from output-0, output-1 and output-2

    IO.puts("***************************************************")
    IO.puts("Puzzle #2: #{
                  String.to_integer(hd(final_values["output-0"]))
                  * String.to_integer(hd(final_values["output-1"]))
                  * String.to_integer(hd(final_values["output-2"]))
              }")
    IO.puts("***************************************************")



    IO.puts "Ending time: " <> DateTime.to_string(DateTime.utc_now)



  end
end





#AoC1610.run("1610.test.input")

AoC1610.run("1610.real.input")
