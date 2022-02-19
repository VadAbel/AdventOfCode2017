defmodule Aoc2017Test.Day03Test do
  use ExUnit.Case
  import Aoc2017.Day03

  doctest Aoc2017.Day03

  # @test_input """
  # """

  test "Day03 Test1" do
    assert solution1("1") == 0
    assert solution1("12") == 3
    assert solution1("23") == 2
    assert solution1("1024") == 31
  end

  test "Day03 Test2" do
    # assert solution2(@test_input) == nil
  end
end
