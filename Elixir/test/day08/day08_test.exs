defmodule Aoc2017Test.Day08Test do
  use ExUnit.Case
  import Aoc2017.Day08

  doctest Aoc2017.Day08

  @test_input """
  b inc 5 if a > 1
  a inc 1 if b < 5
  c dec -10 if a >= 1
  c inc -20 if c == 10

  """

  test "Day08 Test1" do
    assert solution1(@test_input) == 1
  end

  test "Day08 Test2" do
    assert solution2(@test_input) == 10
  end
end
