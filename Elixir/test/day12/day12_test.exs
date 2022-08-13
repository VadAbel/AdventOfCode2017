defmodule Aoc2017Test.Day12Test do
  use ExUnit.Case
  import Aoc2017.Day12

  doctest Aoc2017.Day12

  @test_input """
  0 <-> 2
  1 <-> 1
  2 <-> 0, 3, 4
  3 <-> 2, 4
  4 <-> 2, 3, 6
  5 <-> 6
  6 <-> 4, 5
  """

  test "Day12 Test1" do
    assert solution1(@test_input) == 6
  end

  test "Day12 Test2" do
    assert solution2(@test_input) == 2
  end
end
