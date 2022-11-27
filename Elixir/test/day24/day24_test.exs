defmodule Aoc2017Test.Day24Test do
  use ExUnit.Case
  import Aoc2017.Day24

  doctest Aoc2017.Day24

  @test_input """
  0/2
  2/2
  2/3
  3/4
  3/5
  0/1
  10/1
  9/10
  """

  test "Day24 Test1" do
    assert solution1(@test_input) == 31
  end

  test "Day24 Test2" do
    assert solution2(@test_input) == 19
  end
end
