defmodule Aoc2017Test.Day02Test do
  use ExUnit.Case
  import Aoc2017.Day02

  doctest Aoc2017.Day02

  @test_input """
  5 1 9 5
  7 5 3
  2 4 6 8
  """
  @test_input_2 """
  5 9 2 8
  9 4 7 3
  3 8 6 5
  """

  test "Day02 Test1" do
    assert solution1(@test_input) == 18
  end

  test "Day02 Test2" do
    assert solution2(@test_input_2) == 9
  end
end
