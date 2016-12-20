defmodule AoC1611 do



def valid(state) do

  current_floor = state[{:elevator, :elevator}]

  cond do
    current_floor < 1 -> false
    current_floor > 4 -> false

    # Are there any microchips on this floor for which there isn't a corresponding generator
    # while there is at least a non-corresponding generator

    Map.to_list(state)
      |> Enum.filter(fn {{_, type}, _} -> type != :elevator end)
      |> Enum.partition(fn {{_, type}, _} -> type == :microchip end)
      |> Tuple.to_list
      |> Enum.map(fn type -> Enum.map(type, fn {{item, _}, floor} -> {item, floor} end) end)
      |> List.to_tuple
      |> (fn {microchip, generator} -> {Enum.reject(microchip, fn {chip, chip_floor} -> Enum.any?(generator, fn {gen, gen_floor} -> gen == chip and gen_floor == chip_floor end) end), generator} end).()
      |> (fn {microchip, generator} -> Enum.filter(microchip, fn {chip, chip_floor} -> Enum.any?(generator, fn {gen, gen_floor} -> gen != chip and gen_floor == chip_floor end) end) end).()
      |> Enum.count

        > 0 -> false

    true -> true
  end

end

def move(state, _, []), do: state

def move(state, floor, [item|rest]) do
  Map.put(state, item, floor)
    |> move(floor, rest)
end

def state_from_move(state, [floor|items]) do
   move(state, floor, [{:elevator, :elevator}] ++ items)
end


def output(state, previous_states, _, _) do

  s = Map.values(state) |> Enum.join
  p = Enum.map(previous_states, fn p -> Map.values(p) |> Enum.join end) |> Enum.join(", ")

  IO.puts("\n#{s}")
  IO.puts("    #{p}")
end

def generate_moves(_, previous_states, _, {min, _}, _) when length(previous_states) >= min do
  nil
end

def generate_moves(goal, previous_states, _, _, goal) do
  IO.puts("GOOOOOOOOOOAAAAAAL!  #{length(previous_states)}")

  {length(previous_states), [goal] ++ previous_states}
  # IO.inspect({length(previous_states)+1, [goal] ++ previous_states})
end

def generate_moves(state, previous_states, current_floor, min_moves, goal) do

  #IO.inspect(["STATE", Map.values(state) |> Enum.join , Enum.map(previous_states, fn p -> Map.values(p) |> Enum.join end), current_floor])
  #output(state, previous_states, current_floor, goal)

  equipment = Map.to_list(state)
                |> Enum.filter(fn {{_, type}, floor} -> type != :elevator and floor == current_floor end)
                |> Enum.map(fn {{element, type}, _} -> {element, type} end)

  # IO.inspect(equipment)

  possible_moves =
  for dest <- [current_floor-1, current_floor+1],
      item1 <- equipment,
      item2 <- equipment,
      dest >= 1,
      dest <= 4
  do
      if item2 == item1, do: {dest, item1}, else: {dest, item1, item2}
  end
      |> Enum.map(&Tuple.to_list/1)

  new_states = Enum.map(possible_moves, fn x -> state_from_move(state, x) end)

  # IO.inspect(["NEW STATES", new_states])

  new_valid_states =  Enum.filter(new_states, fn s -> valid(s) end)
                          |> Enum.reject(fn x -> Enum.member?(previous_states, x) end)
                          |> Enum.uniq

  # IO.inspect(["NEW VALID STATES", new_valid_states])

  if new_valid_states == [] do
    nil # {:infinite, [state] ++ previous_states}
  else
    # if min_moves != nil do
    #   IO.inspect(["ACC:", elem(min_moves,0)])
    # end

    Enum.reduce(new_valid_states, min_moves, fn (x,acc) ->
        new_val = generate_moves(x, [state] ++ previous_states, x[{:elevator, :elevator}], acc, goal)
        cond do
          acc     == nil  -> new_val
          new_val == nil  -> acc
          true            -> Enum.min_by([acc, new_val], fn {min,_} -> min end)
        end
      end)
  end

end

def generate_moves(state) do
  generate_moves(state, [], 1, nil, goal(state))
end

def parse_equipment(line, regex, equipment_type) do
  Regex.scan(regex, line)
    |> Enum.reduce([], fn x,acc -> acc ++ [{x |> tl |> hd |> String.to_atom, equipment_type}] end)
end

def parse_line(line) do

  floor       = Regex.run(~r/The ([a-z]+) floor/, line)
                  |> List.last
                  |> (fn r -> Enum.find_index(["first", "second", "third", "fourth"], fn x -> x == r end) + 1 end).()

  generators  = parse_equipment(line, ~r/a ([a-z]+) generator/, :generator)
  microchips  = parse_equipment(line, ~r/a ([a-z]+)-compatible microchip/, :microchip)

  Enum.map(generators ++ microchips, fn x -> {x, floor} end)

end

def initial_state(file) do
  File.stream!(file, [:utf8])
    |> Enum.map(&(String.strip/1))
    |> Enum.map(&(parse_line/1))
    |> List.flatten
    |> Enum.into(%{})
    |> Map.put({:elevator, :elevator}, 1)

end

def goal(state) do
  Map.keys(state)
    |> Enum.map(fn x -> {x, 4} end)
    |> Enum.into(%{})
end

def run(file) do
  initial_state(file)
    |> generate_moves()
    |> (fn {n, moves} ->
          IO.inspect({n, moves})
          n
        end).()
end


end
