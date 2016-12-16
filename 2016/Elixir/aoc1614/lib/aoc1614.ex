defmodule AoC1614 do

  def hd_tl_not_nil(expr) do
    case expr do
      nil -> nil
      _ -> hd(tl(expr))
    end
  end

  def md5_compute(str, stretching) do
    md5 = String.downcase(Base.encode16(:crypto.hash(:md5, str)))

    case stretching do
      0 -> md5
      _ -> md5_compute(md5, stretching-1)
    end
  end


  def md5_parse(n, salt, stretching) do
    md5_compute(salt <> to_string(n), stretching)
      |> (fn x -> [ n, Regex.run(~r/([a-f0-9])\1\1/, x), Regex.run(~r/([a-f0-9])\1\1\1\1/, x) ] end).()
      |> (fn [n, r3, r5] -> [n, hd_tl_not_nil(r3), hd_tl_not_nil(r5)] end).()
  end

  def iter(verified, _, _, _, _) when length(verified) == 64 do
    [first | _] = verified
    [n, _, _] = first
    n
  end

  def iter(verified, lookahead, n, salt, stretching) when length(lookahead) == 0 do
    iter(verified, [md5_parse(n, salt, stretching)], n, salt, stretching)
  end


  def iter(verified, lookahead, n, salt, stretching) when length(lookahead) < 1001 do

    i = hd(hd(lookahead))

    new_list =  (n+1 .. i+1000)
                  |> Enum.map(&md5_parse(&1, salt, stretching))

    iter(verified, lookahead ++ new_list, i+1000, salt, stretching)
  end

  def iter(verified, lookahead, n, salt, stretching) when tl(hd(lookahead)) == [nil, nil] do

    # IO.inspect(["TRYING", tl(lookahead)])

    iter(verified, tl(lookahead), n, salt, stretching)
  end


  def iter(verified, lookahead, n, salt, stretching) do
    # IO.puts("up to n: #{n}, len= #{length(lookahead)}")

    [first | rest] = lookahead

    [_, r3, _] = first

    # IO.inspect(["FIRST:", first])
    # IO.inspect(["REST:", rest |> Enum.filter(fn [_, _, l] -> l != nil end) ])

    new_verified = if Enum.any?(rest, fn [_, _, other_r5] -> other_r5 == r3 end) do
      [first] ++ verified
    else
      verified
    end

    # IO.inspect(["VERIFIED:", new_verified])

    iter(new_verified, rest, n, salt, stretching)
  end



  def run(salt, stretching \\ 0) do

    IO.puts "Starting time: " <> DateTime.to_string(DateTime.utc_now)

    x = iter([], [], 0, salt, stretching)

    IO.puts("Answer for #{salt} is: #{x}" )


    IO.puts "Ending time: " <> DateTime.to_string(DateTime.utc_now)

    x
  end
end
