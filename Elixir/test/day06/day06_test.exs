defmodule Aoc2017Test.Day06Test do
  use ExUnit.Case
  import Aoc2017.Day06

  doctest Aoc2017.Day06

  @test_input """
  0 2 7 0
  """

  test "Day06 Test1" do
    assert solution1(@test_input) == 5
  end

  test "Day06 Test2" do
    assert solution2(@test_input) == 4
  end
end
