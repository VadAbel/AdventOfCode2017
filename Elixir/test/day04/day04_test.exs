defmodule Aoc2017Test.Day04Test do
  use ExUnit.Case
  import Aoc2017.Day04

  doctest Aoc2017.Day04

  # @test_input """
  # """

  test "Day04 Test1" do
    assert solution1("aa bb cc dd ee") == 1
    assert solution1("aa bb cc dd aa") == 0
    assert solution1("aa bb cc dd aaa") == 1
  end

  test "Day04 Test2" do
    assert solution2("abcde fghij") == 1
    assert solution2("abcde xyz ecdab") == 0
    assert solution2("a ab abc abd abf abj") == 1
    assert solution2("iiii oiii ooii oooi oooo") == 1
    assert solution2("oiii ioii iioi iiio") == 0
  end
end
