defmodule AoC1609 do

  def run(string, puzzle, acc \\ 0) do

    group = Regex.run(~r/[^\(]*\([0-9]+x[0-9]+\)/, string)

    IO.inspect(["String: #{string} ACC: #{acc}", group])

    if group do

      group_str = group |> hd
      group_len = String.length(group_str)

      match = Regex.named_captures(~r/(?<skip>[^\(]*)\((?<compressed>[0-9]+)x(?<repetitions>[0-9]+)\)/, group_str)

      IO.inspect([match])

      skip = match["skip"]
      skip_len = String.length(skip)

      compressed_len = String.to_integer(match["compressed"])
      compressed_str = String.slice(string, group_len..group_len+compressed_len-1)
      repetitions = String.to_integer(match["repetitions"])

      decompressed_len = case puzzle do
        :puzzle1 ->
          decompressed_len = compressed_len * repetitions

        :puzzle2 ->
          decompressed_len = run(compressed_str, :puzzle2) * repetitions
      end

      IO.puts("## #{compressed_str} (#{compressed_len},#{repetitions}), Decompressed Length: #{decompressed_len} Grouplen: #{group_len}")

      decompressed_str = run(String.slice(string, group_len+compressed_len..-1), puzzle, acc + skip_len + decompressed_len)
      IO.puts("Decompressed String: #{decompressed_str}")
      decompressed_str

    else
      acc + String.length(string)
    end
  end

end

IO.puts "Starting time: " <> DateTime.to_string(DateTime.utc_now)

#AoC1609.run("(6x1)(1x3)A, :puzzle1")
#AoC1609.run("A(2x2)BCD(2x2)EFG", :puzzle1)


#AoC1609.run("X(8x2)(3x3)ABCY", :puzzle1)
#AoC1609.run("X(8x2)(3x3)ABCY", :puzzle2)

AoC1609.run("(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN", :puzzle2)

AoC1609.run("(27x12)(20x12)(13x14)(7x10)(1x12)A", :puzzle2)

#AoC1609.run(File.stream!("1609.real.input", [:utf8]) |> Enum.map(&(String.strip/1)) |> Enum.join(), :puzzle1)
AoC1609.run(File.stream!("1609.real.input", [:utf8]) |> Enum.map(&(String.strip/1)) |> Enum.join(), :puzzle2)



IO.puts "Ending time: " <> DateTime.to_string(DateTime.utc_now)
