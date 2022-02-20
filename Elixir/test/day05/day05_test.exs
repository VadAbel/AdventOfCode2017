defmodule Aoc2017Test.Day05Test do
  use ExUnit.Case
  import Aoc2017.Day05

  doctest Aoc2017.Day05

  @test_input """
  0
  3
  0
  1
  -3
  """

  test "Day05 Test1" do
    assert solution1(@test_input) == 5
  end

  test "Day05 Test2" do
    assert solution2(@test_input) == 10
  end
end
