defmodule Aoc2017Test.Day16Test do
  use ExUnit.Case
  import Aoc2017.Day16

  doctest Aoc2017.Day16

  @test_input "s1,x3/4,pe/b"

  test "Day16 Test1" do
    assert solution1(@test_input, ?a..?e) == "baedc"
  end

  test "Day16 Test2" do
    assert solution2(@test_input, ?a..?e, 2) == "ceadb"
  end
end
