defmodule Aoc2017Test.Day15Test do
  use ExUnit.Case
  import Aoc2017.Day15

  doctest Aoc2017.Day15

  @test_input """
  Generator A starts with 65
  Generator B starts with 8921
  """

  test "Day15 Test1" do
    assert solution1(@test_input) == 588
  end

  test "Day15 Test2" do
    assert solution2(@test_input) == 309
  end
end
