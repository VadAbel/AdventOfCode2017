defmodule Aoc2017Test.Day07Test do
  use ExUnit.Case
  import Aoc2017.Day07

  doctest Aoc2017.Day07

  @test_input """
  pbga (66)
  xhth (57)
  ebii (61)
  havc (66)
  ktlj (57)
  fwft (72) -> ktlj, cntj, xhth
  qoyq (66)
  padx (45) -> pbga, havc, qoyq
  tknk (41) -> ugml, padx, fwft
  jptl (61)
  ugml (68) -> gyxo, ebii, jptl
  gyxo (61)
  cntj (57)
  """

  test "Day07 Test1" do
    assert solution1(@test_input) == "tknk"
  end

  test "Day07 Test2" do
    assert solution2(@test_input) == 60
  end
end
