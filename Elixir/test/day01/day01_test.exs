defmodule Aoc2017Test.Day01Test do
  use ExUnit.Case
  import Aoc2017.Day01

  doctest Aoc2017.Day01

  # @test_input """
  # """

  test "Day01 Test1" do
    assert solution1("1122") == 3
    assert solution1("1111") == 4
    assert solution1("1234") == 0
    assert solution1("91212129") == 9
  end

  test "Day01 Test2" do
    assert solution2("1212") == 6
    assert solution2("1221") == 0
    assert solution2("123425") == 4
    assert solution2("123123") == 12
    assert solution2("12131415") == 4
  end
end
