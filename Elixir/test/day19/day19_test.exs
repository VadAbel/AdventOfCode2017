defmodule Aoc2017Test.Day19Test do
  use ExUnit.Case
  import Aoc2017.Day19

  doctest Aoc2017.Day19

  @test_input """
      |
      |  +--+
      A  |  C
  F---|----E|--+
      |  |  |  D
      +B-+  +--+
  """

  test "Day19 Test1" do
    assert solution1(@test_input) == "ABCDEF"
  end

  test "Day19 Test2" do
    assert solution2(@test_input) == 38
  end
end
