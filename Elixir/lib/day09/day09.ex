defmodule Aoc2017.Day09 do
  @moduledoc false

  @day "09"
  @input_file "../inputs/day#{@day}.txt"

  def group_count(text, group_level \\ 0, garbage_state \\ false)

  def group_count("", _group_level, _garbage_state), do: 0

  def group_count(<<?!, _b::bytes-size(1), rest::binary>>, group_level, garbage_state),
    do: group_count(rest, group_level, garbage_state)

  def group_count(<<?<, rest::binary>>, group_level, _garbage_state),
    do: group_count(rest, group_level, true)

  def group_count(<<?>, rest::binary>>, group_level, _garbage_state),
    do: group_count(rest, group_level, false)

  def group_count(<<?{, rest::binary>>, group_level, garbage_state) when garbage_state == false,
    do: group_count(rest, group_level + 1, garbage_state)

  def group_count(<<?}, rest::binary>>, group_level, garbage_state)
      when garbage_state == false and group_level > 0,
      do: group_level + group_count(rest, group_level - 1, garbage_state)

  def group_count(<<_a::bytes-size(1), rest::binary>>, group_level, garbage_state),
    do: group_count(rest, group_level, garbage_state)

  def garbage_count(text, garbage_state \\ false)
  def garbage_count("", _garbage_state), do: 0

  def garbage_count(<<?!, _b::bytes-size(1), rest::binary>>, garbage_state),
    do: garbage_count(rest, garbage_state)

  def garbage_count(<<?<, rest::binary>>, garbage_state) when garbage_state == false,
    do: garbage_count(rest, true)

  def garbage_count(<<?>, rest::binary>>, garbage_state) when garbage_state == true,
    do: garbage_count(rest, false)

  def garbage_count(<<_a::bytes-size(1), rest::binary>>, garbage_state)
      when garbage_state == true,
      do: 1 + garbage_count(rest, garbage_state)

  def garbage_count(<<_a::bytes-size(1), rest::binary>>, garbage_state)
      when garbage_state == false,
      do: garbage_count(rest, garbage_state)

  def solution1(input) do
    input
    |> group_count()
  end

  def solution2(input) do
    input
    |> garbage_count()
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  11846
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part2()
  6285
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
  end
end
