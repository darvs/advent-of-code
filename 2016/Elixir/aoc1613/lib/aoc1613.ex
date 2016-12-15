defmodule AoC1613 do

  def pow(base, exponent) do
    round(:math.pow(base, exponent))
  end

  def to_binary(n) do
    to_string(hd(:io_lib.format("~.2B", [n])))
  end

  def number_of_ones(n) do
    to_binary(n)
      |> String.codepoints
      |> Enum.filter(fn x -> x == "1" end)
      |> Enum.count
  end

  defp is_open({x,y}, input) do
    require(Integer)

    Integer.is_even(
                    ((x*x + 3*x + 2*x*y + y + y*y) + input)
                      |> number_of_ones
                  )
  end

  defp neighbors({x,y}) do
    [{x, y+1}, {x+1, y}, {x, y-1}, {x-1, y}]
      |> Enum.filter(fn {x,y} -> x >= 0 && y >= 0 end)
  end

  # defp open_neighbors(list, []) do
  #   IO.inspect(["1:", list])
  #   []
  # end

  # defp open_neighbors(input, list) when length(list) > 1 do
  #   Enum.map(list, fn {x,y} -> open_neighbors(input, open_neighbors(input, [{x,y}])) end)
  # end



  # defp open_neighbors(input, already_checked, list) do
  #   IO.inspect(["2: list", list])
  #   IO.inspect(["2: already checked", already_checked])
  #
  #   Enum.filter(list, fn b -> !Enum.member?(already_checked, b) end)
  #       |> Enum.map(fn {x,y} -> neighbors({x, y})
  #                                       |> Enum.filter(fn {x,y} -> is_open(input, {x,y}) end)
  #                                     end)
  #       |> Enum.map(fn a -> open_neighbors(input, List.flatten([already_checked | list]), a) end)
  #
  # end

  defp open_neighbors({x,y}, acc, input, destination) do

    # IO.inspect(["open_neighbors", {x,y}, acc, input, destination])
    # IO.inspect(["open_neighbors", {x,y}])

    if {x,y} == destination do
      len = Enum.count(acc) - 1
      #IO.inspect(["Len:", len, Enum.reverse(acc)])

      List.to_tuple(Enum.reverse(acc))
    else

      list =  neighbors({x, y})
                |> Enum.filter(fn z -> is_open(z, input) end)
                |> Enum.filter(fn c -> !Enum.member?(acc, c) end)

    # IO.inspect(["open_neighbors", {x,y}, list])

      path =
        case list do
          []  -> []
          _   -> Enum.map(list, fn p -> open_neighbors(p, [p | acc], input, destination) end) |> Enum.filter(fn q -> q != [] end)
        end
    end

  end

  defp open_neighbors(p, input, destination) do
    open_neighbors(p, [p], input, destination)
      |> List.flatten
      |> Enum.map(fn x -> Tuple.to_list(x) end)
      |> Enum.map(fn x -> [length(x)-1, x] end)
      |> Enum.sort
  end


  # defp open_neighbors(input, list) do
  #   IO.inspect(["3:", list])
  #
  #   Enum.map(list, fn a -> open_neighbors(input, a) end)
  #
  # end


  def run(input, destination) do

    IO.puts "Starting time: " <> DateTime.to_string(DateTime.utc_now)

    x = open_neighbors({1,1}, input, destination)

    IO.inspect(x)

    # x |> Enum.map(fn x -> IO.inspect(x) end)

    IO.puts "Ending time: " <> DateTime.to_string(DateTime.utc_now)

  end

end
