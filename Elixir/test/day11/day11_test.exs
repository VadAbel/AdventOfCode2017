defmodule Aoc2017Test.Day11Test do
  use ExUnit.Case
  import Aoc2017.Day11

  doctest Aoc2017.Day11

  # @test_input """
  # """

  test "Day11 Test1" do
    assert solution1("ne,ne,ne") == 3
    assert solution1("ne,ne,sw,sw") == 0
    assert solution1("ne,ne,s,s") == 2
    assert solution1("se,sw,se,sw,sw") == 3
  end

  test "Day11 Test2" do
    # assert solution2(@test_input) == nil
  end
end
