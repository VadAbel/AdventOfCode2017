defmodule Aoc2017Test.Day10Test do
  use ExUnit.Case
  import Aoc2017.Day10

  doctest Aoc2017.Day10

  @test_input "3,4,1,5"

  test "Day10 Test1" do
    assert solution1(@test_input, 5) == 12
  end

  test "Day10 Test2" do
    assert solution2("1,2,3") == "3efbe78a8d82f29979031a4aa0b16a9d"
    assert solution2("") == "a2582a3a0e66e6e86e3812dcb672a272"
    assert solution2("AoC 2017") == "33efeb34ea91902bb2f59c9920caa6cd"
    assert solution2("1,2,4") == "63960835bcdc130f0b66d7ff4f6a5a8e"
  end
end
