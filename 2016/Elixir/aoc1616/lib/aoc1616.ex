defmodule AoC1616 do
  require(Integer)

def invert([], acc) do
  Enum.join(acc)
end

def invert(["1" | rest], acc) do
  invert(rest, ["0"] ++ acc)
end

def invert(["0" | rest], acc) do
  invert(rest, ["1"] ++ acc)
end

def invert(string) do
  invert(String.graphemes(string), [])
end

def dragon(string, len) do
  if String.length(string) < len do
    dragon(string <> "0" <> invert(string), len)
  else
    String.slice(string, 0, len)
  end
end

def checksum("00"), do: "1"
def checksum("01"), do: "0"
def checksum("10"), do: "0"
def checksum("11"), do: "1"

def checksum(string) do

  if String.length(string) |> Integer.is_odd do
    string

  else
    Regex.scan(~r/../, string)
      |> Enum.map(&(hd/1))
      |> Enum.map(&(checksum/1))
      |> Enum.join
      |> checksum

  end

end

def run(initial, len) do
  dragon(initial, len) |> checksum
end


end
