defmodule Aoc2017Test.Day18Test do
  use ExUnit.Case
  import Aoc2017.Day18

  doctest Aoc2017.Day18

  @test_input """
  set a 1
  add a 2
  mul a a
  mod a 5
  snd a
  set a 0
  rcv a
  jgz a -1
  set a 1
  jgz a -2
  """

  test "Day18 Test1" do
    assert solution1(@test_input) == 4
  end

  test "Day18 Test2" do
    # assert solution2(@test_input) == nil
  end
end
