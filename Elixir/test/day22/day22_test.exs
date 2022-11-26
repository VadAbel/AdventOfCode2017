defmodule Aoc2017Test.Day22Test do
  use ExUnit.Case
  import Aoc2017.Day22

  doctest Aoc2017.Day22

  @test_input """
  ..#
  #..
  ...
  """

  test "Day22 Test1" do
    assert solution1(@test_input, 7) == 5
    assert solution1(@test_input) == 5587
  end

  test "Day22 Test2" do
    assert solution2(@test_input, 100) == 26
    assert solution2(@test_input) == 2_511_944
  end
end
