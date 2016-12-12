defmodule AoC1612 do
  def next_instruction(program, registers) do
    #IO.puts("inc1")
    registers = exec("inc", ["pc"], program, registers)
    exec(program, registers)
  end

  def exec("inc", parms, program, registers) do
    [reg | p2] = parms
    add = (if p2 == [], do: 1, else: hd(p2))
    #IO.inspect(["inc2", reg, add, String.to_atom(reg), registers])
    registers = elem(Map.get_and_update(registers, String.to_atom(reg), fn current -> {current, current+add} end), 1)
    #IO.inspect(["after inc2", reg, add, String.to_atom(reg), registers])

    registers =
      case reg do
        "pc" -> registers
        _ -> next_instruction(program, registers)
      end

      registers
  end

  def exec("dec", parms, program, registers) do
    [reg | value] = parms
    #IO.puts("dec #{reg}, #{value}")
    exec("inc", [reg | [-1]], program, registers)
  end

  def exec("cpy", parms, program, registers) do
    [p1 | reg] = parms

    p1_int = Integer.parse(p1)
    p1_int = case p1_int do
      :error -> Map.get(registers, String.to_atom(p1), -1000)
      _ -> elem(p1_int,0)
    end

    registers = elem(Map.get_and_update(registers, String.to_atom(hd(reg)), fn current -> {current, p1_int} end), 1)

    registers =
      case reg do
        "pc" -> registers
        _ -> next_instruction(program, registers)
      end

      registers
  end

  def exec("jnz", parms, program, registers) do
    [reg | p2] = parms

    reg_int = Integer.parse(reg)
    reg_int = case reg_int do
      :error -> Map.get(registers, String.to_atom(reg), -1000)
      _ -> elem(reg_int,0)
    end

    if reg_int != 0 do
      registers = exec("inc", ["pc", String.to_integer(hd(p2))], program, registers)
      exec(program, registers)
    else
      next_instruction(program, registers)
    end

    registers
  end



  def exec(inst, parms, program, registers) do
    IO.puts("Ignoring #{inst}")
    next_instruction(program, registers)
  end

  def exec(program, registers \\ %{pc: 0, "a": 0, "b": 0, "c": 0, "d": 0} ) do
      #IO.inspect(["fn", program, registers])

      pc = Map.fetch!(registers, :pc)

      if pc < Enum.count(program) do
        [inst | parms] = elem(Enum.at(program, pc),0)


        exec(inst, parms, program, registers)
        #IO.inspect([inst, parms, registers])

      else
        IO.inspect(["THE END:", registers])
      end
  end

  def run(file) do

    program = File.stream!(file, [:utf8])
      |> Enum.map(&(String.strip/1))
      |> Enum.map(&(String.split/1))
      |> Enum.with_index

      IO.inspect(["PROGRAM:", program])

      exec(program)
  end
end





#AoC1612.run("1612.test.input")
#AoC1612.run("1612.test2.input")

AoC1612.run("1612.real.input")
