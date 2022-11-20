defmodule Aoc2017Test.Day20Test do
  use ExUnit.Case
  import Aoc2017.Day20

  doctest Aoc2017.Day20

  @test_input """
  p=< 3,0,0>, v=< 2,0,0>, a=<-1,0,0>
  p=< 4,0,0>, v=< 0,0,0>, a=<-2,0,0>
  """
  @test_input_2 """
  p=<-6,0,0>, v=< 3,0,0>, a=< 0,0,0>
  p=<-4,0,0>, v=< 2,0,0>, a=< 0,0,0>
  p=<-2,0,0>, v=< 1,0,0>, a=< 0,0,0>
  p=< 3,0,0>, v=<-1,0,0>, a=< 0,0,0>
  """

  test "Day20 Test1" do
    assert solution1(@test_input) == 0
  end

  test "Day20 Test2" do
    assert solution2(@test_input_2) == 1
  end
end
