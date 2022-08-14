defmodule Aoc2017Test.Day13Test do
  use ExUnit.Case
  import Aoc2017.Day13

  doctest Aoc2017.Day13

  @test_input """
  0: 3
  1: 2
  4: 4
  6: 4
  """

  test "Day13 Test1" do
    assert solution1(@test_input) == 24
  end

  test "Day13 Test2" do
    assert solution2(@test_input) == 10
  end
end
