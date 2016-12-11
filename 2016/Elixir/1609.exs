defmodule AoC1609 do

  def run(string, acc \\ 0)

  def run(string, acc) when string == "" do
    acc
  end

  def run(string, acc) do

    IO.puts("String: #{string}")

    group = Regex.run(~r/[^\(]*\([0-9]+x[0-9]+\)/, string)

    IO.inspect(group)

    if group do

      group_str = group |> hd
      group_len = String.length(group_str)

      match = Regex.named_captures(~r/(?<skip>[^\(]*)\((?<compressed>[0-9]+)x(?<repetitions>[0-9]+)\)/, group_str)

      IO.inspect([match])

      skip = match["skip"]
      skip_len = String.length(skip)

      compressed = String.to_integer(match["compressed"])
      repetitions = String.to_integer(match["repetitions"])

      IO.puts("Compressed: #{compressed} Repetitions: #{repetitions}, Grouplen: #{group_len}")


      run(String.slice(string, group_len+compressed..-1), acc + skip_len + (compressed * repetitions))
    else
      acc + String.length(string)
    end
  end

end

IO.puts "Starting time: " <> DateTime.to_string(DateTime.utc_now)

#AoC1609.run("X(8x2)(3x3)ABCY")
#AoC1609.run("(6x1)(1x3)A")
#AoC1609.run("A(2x2)BCD(2x2)EFG")

AoC1609.run(
  File.stream!("1609.real.input", [:utf8])
    |> Enum.map(&(String.strip/1))
    |> Enum.join
  )


IO.puts "Ending time: " <> DateTime.to_string(DateTime.utc_now)
