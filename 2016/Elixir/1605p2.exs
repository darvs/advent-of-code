# [[index: 3231929, str: "abc3231929", hash: "00000155f8105dff7f56ee10fa9b9abd",  pos: "1"],
#  [index: 5357525, str: "abc5357525", hash: "000004e597bd77c5cd2133e9d885fe7e",  pos: "4"],
#  [index: 5708769, str: "abc5708769", hash: "0000073848c9ff7a27ca2e942ac10a4c",  pos: "7"],
#  [index: 8036669, str: "abc8036669", hash: "000003c75169d14fdb31ec1593915cff",  pos: "3"],
#  [index: 8605828, str: "abc8605828", hash: "0000000ea49fd3fc1b2f10e02d98ee96",  pos: "0"],
#  [index: 8609554, str: "abc8609554", hash: "000006e42e097c536b8be5179d65f327",  pos: "6"],
#  [index: 13666005, str: "abc13666005", hash: "0000058939cbc6a1d1ab3bf7d29b0764",  pos: "5"],
#  [index: 13753421, str: "abc13753421", hash: "000002af5a2d97ef50063c37644d0166",  pos: "2"]] \


IO.puts "Starting time: " <> DateTime.to_string(DateTime.utc_now)

id="cxdnnyjw"
#id="abc"

Stream.iterate(0, &(&1+1)) \
  |> Stream.map(&([index: &1, str: id <> to_string(&1)])) \
  |> Stream.map(&(&1 ++ [hash: String.downcase(Base.encode16(:crypto.hash(:md5, &1[:str])))])) \
  |> Stream.filter(&(String.starts_with?(&1[:hash], "00000"))) \
  |> Stream.map(&(&1 ++ [pos: String.at(&1[:hash], 5)])) \
  |> Stream.filter(&(String.contains?("01234567", &1[:pos]))) \
  |> Stream.uniq(&(&1[:pos])) \
  |> Enum.take(8) \
  |> Enum.map(&([pos: &1[:pos], decrypted: String.at(&1[:hash], 6)])) \
  |> Enum.sort(&(&1[:pos] < &2[:pos])) \
  |> Enum.map(&(&1[:decrypted])) \
  |> Enum.join

IO.puts "Ending time: " <> DateTime.to_string(DateTime.utc_now)
