defmodule Aoc2017.Day10 do
  @moduledoc false

  @day "10"
  @input_file "../inputs/day#{@day}.txt"

  @circle_size 256
  @salt [17, 31, 73, 47, 23]
  @knot_round 64
  @chunk_size 16

  import Bitwise

  def parser(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def parser2(input) do
    input
    |> String.to_charlist()
    |> Enum.concat(@salt)
  end

  def knot(sequence, elements, time) do
    {elements, position, _skip_size} =
      Enum.reduce(1..time, {elements, 0, 0}, fn _x, acc -> knot(sequence, acc) end)

    {a, b} = Enum.split(elements, -position)
    b ++ a
  end

  def knot([], {elements, position, skip_size}), do: {elements, position, skip_size}

  def knot([reverse_lenght | reverse_rest], {elements, position, skip_size}) do
    {a, b} = Enum.split(elements, reverse_lenght)
    {c, d} = Enum.split(b ++ Enum.reverse(a), skip_size)
    new_elements = d ++ c

    knot(
      reverse_rest,
      {
        new_elements,
        rem(position + reverse_lenght + skip_size, length(new_elements)),
        rem(skip_size + 1, length(new_elements))
      }
    )
  end

  def solution1(input, size \\ @circle_size) do
    input
    |> parser()
    |> knot(Enum.to_list(0..(size - 1)), 1)
    |> Enum.take(2)
    |> Enum.product()
  end

  def solution2(input) do
    input
    |> parser2()
    |> knot(Enum.to_list(0..(@circle_size - 1)), @knot_round)
    |> Enum.chunk_every(@chunk_size)
    |> Enum.map_join(fn list ->
      Enum.reduce(list, fn x, acc ->
        bxor(acc, x)
      end)
      |> Integer.to_string(16)
      |> String.downcase()
      |> String.pad_leading(2, "0")
    end)
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  6909
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part2()
  "9d5f4561367d379cfbf04f8c471c0095"
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
  end
end
