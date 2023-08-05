defmodule Aoc2017.Day17 do
  @moduledoc false

  @day "17"
  @input_file "../inputs/day#{@day}.txt"

  @limit_1 2017
  @limit_2 50_000_000

  def parser(input) do
    String.to_integer(input)
  end

  def spinlock(_rotate, state, pos, t, limit) when t > limit,
    do: Enum.at(state, rem(pos + 1, @limit_1))

  def spinlock(rotate, state, pos, t, limit) do
    new_pos = rem(pos + rotate, t) + 1

    spinlock(rotate, List.insert_at(state, new_pos, t), new_pos, t + 1, limit)
  end

  def spinlock2(_rotate, value, _pos, t, limit) when t > limit, do: value

  def spinlock2(rotate, value, pos, t, limit) do
    new_pos = rem(pos + rotate, t) + 1
    new_value = if new_pos == 1, do: t, else: value

    spinlock2(rotate, new_value, new_pos, t + 1, limit)
  end

  def solution1(input) do
    input
    |> parser()
    |> spinlock([0], 0, 1, @limit_1)
  end

  def solution2(input) do
    input
    |> parser()
    |> spinlock2([0], 0, 1, @limit_2)
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  866
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part2()
  11995607
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
  end
end
