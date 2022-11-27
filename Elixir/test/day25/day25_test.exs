defmodule Aoc2017Test.Day25Test do
  use ExUnit.Case
  import Aoc2017.Day25

  doctest Aoc2017.Day25

  @test_input """
  Begin in state A.
  Perform a diagnostic checksum after 6 steps.

  In state A:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state B.
  If the current value is 1:
    - Write the value 0.
    - Move one slot to the left.
    - Continue with state B.

  In state B:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the left.
    - Continue with state A.
  If the current value is 1:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state A.
  """

  test "Day25 Test1" do
    assert solution1(@test_input) == 3
  end

  test "Day25 Test2" do
    # assert solution2(@test_input) == nil
  end
end
