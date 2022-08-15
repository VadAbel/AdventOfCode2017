defmodule Aoc2017Test.Day14Test do
  use ExUnit.Case
  import Aoc2017.Day14

  doctest Aoc2017.Day14

  @test_input "flqrgnkx"

  test "Day14 Test1" do
    assert solution1(@test_input) == 8108
  end

  test "Day14 Test2" do
    assert solution2(@test_input) == 1242
  end
end
