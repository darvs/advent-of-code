defmodule AoC1611Test do
  use ExUnit.Case
  import AoC1611
  doctest AoC1611


  test "Initial State" do
    assert initial_state("test/input/1611.test.input") ==  %{ {:elevator, :elevator}  => 1,
                                                              {:hydrogen, :generator} => 2,
                                                              {:hydrogen, :microchip} => 1,
                                                              {:lithium,  :generator} => 3,
                                                              {:lithium,  :microchip} => 1 }
  end

  test "Validate" do
    assert initial_state("test/input/1611.test.input") |> valid == true
  end

  test "Invalid Floor #1" do
    assert %{{:elevator, :elevator} => 0} |> valid == false
  end

  test "Invalid Floor #2" do
    assert %{{:elevator, :elevator} => 5} |> valid == false
  end

  test "Fried Lithium Microchip" do
     assert  %{ {:elevator, :elevator}  => 1,
                {:hydrogen, :generator} => 1,
                {:hydrogen, :microchip} => 1,
                {:lithium,  :generator} => 3,
                {:lithium,  :microchip} => 1 }          |> valid == false
  end

  test "All Microchips Connected" do
     assert  %{ {:elevator, :elevator}  => 1,
                {:hydrogen, :generator} => 1,
                {:hydrogen, :microchip} => 1,
                {:lithium,  :generator} => 1,
                {:lithium,  :microchip} => 1 }          |> valid == true
  end

  test "Stealing the Generator Creates Trouble on Another Floor" do
     assert  %{ {:elevator, :elevator}  => 2,
                {:hydrogen, :generator} => 2,
                {:hydrogen, :microchip} => 1,
                {:lithium,  :generator} => 1,
                {:lithium,  :microchip} => 1 }          |> valid == false
  end

  test "GOAL!" do
    assert goal(initial_state("test/input/1611.test.input")) ==  %{ {:elevator, :elevator}  => 4,
                                                                    {:hydrogen, :generator} => 4,
                                                                    {:hydrogen, :microchip} => 4,
                                                                    {:lithium, :generator}  => 4,
                                                                    {:lithium, :microchip}  => 4 }
  end

  test "First Blood" do
    assert run("test/input/1611.test.input") == 11
  end

  test "Puzzle #1" do
    assert run("test/input/1611.real.input") == 0
  end

end
