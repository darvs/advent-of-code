IO.puts "Starting time: " <> DateTime.to_string(DateTime.utc_now)

id="cxdnnyjw"

Stream.iterate(0, &(&1+1)) \
  |> Stream.map(&([index: &1, str: id <> to_string(&1)])) \
  |> Stream.map(&(&1 ++ [hash: String.downcase(Base.encode16(:crypto.hash(:md5, &1[:str])))])) \
  |> Stream.filter(&(String.starts_with?(&1[:hash], "00000"))) \
  |> Enum.take(8) \
  |> Enum.map(&(String.at(&1[:hash], 5))) \
  |> Enum.join

IO.puts "Ending time: " <> DateTime.to_string(DateTime.utc_now)


#[ [index: 3231929, str: "abc3231929", hash: "00000155F8105DFF7F56EE10FA9B9ABD"], \
#  [index: 5017308, str: "abc5017308", hash: "000008F82C5B3924A1ECBEBF60344E00"]] \
