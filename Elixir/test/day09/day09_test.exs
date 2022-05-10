defmodule Aoc2017Test.Day09Test do
  use ExUnit.Case
  import Aoc2017.Day09

  doctest Aoc2017.Day09

  # @test_input """
  # """

  test "Day09 Test1" do
    assert solution1("{}") == 1
    assert solution1("{{{}}}") == 6
    assert solution1("{{},{}}") == 5
    assert solution1("{{{},{},{{}}}}") == 16
    assert solution1("{<a>,<a>,<a>,<a>}") == 1
    assert solution1("{{<ab>},{<ab>},{<ab>},{<ab>}}") == 9
    assert solution1("{{<!!>},{<!!>},{<!!>},{<!!>}}") == 9
    assert solution1("{{<a!>},{<a!>},{<a!>},{<ab>}}") == 3
  end

  test "Day08 Test2" do
    assert solution2("<>") == 0
    assert solution2("<azertyuiopqsdf>") == 14
    assert solution2("<<<<>") == 3
    assert solution2("<{!>}>") == 2
    assert solution2("<!!>") == 0
    assert solution2("<!!!>>") == 0
    assert solution2("<{o\"i!a,<{i<a>") == 10
  end
end
