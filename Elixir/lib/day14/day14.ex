defmodule Aoc2017.Day14 do
  @moduledoc false

  @day "14"
  @input_file "../inputs/day#{@day}.txt"

  @grid_size 128
  @knot_size 256
  @chunk_size 16
  @salt [17, 31, 73, 47, 23]

  import Bitwise

  def parser(input) do
    to_append = String.to_charlist(input <> "-")

    0..(@grid_size - 1)
    |> Enum.map(&(Enum.concat(to_append, Integer.to_charlist(&1)) |> Enum.concat(@salt)))
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

  def knot_hash(sequence, time \\ 64) do
    elements = Enum.to_list(0..(@knot_size - 1))

    knot(sequence, elements, time)
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

  def convert_binary(a) do
    a
    |> String.split("", trim: true)
    |> Enum.map_join(
      &(&1
        |> String.to_integer(16)
        |> Integer.to_string(2)
        |> String.pad_leading(4, "0"))
    )
  end

  def build_grid(keys) do
    keys
    |> Enum.map(fn key ->
      key
      |> knot_hash()
      |> convert_binary()
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer(&1))
    end)
  end

  def list_used(grid) do
    for {line, y} <- Enum.with_index(grid),
        {1, x} <- Enum.with_index(line),
        do: {x, y}
  end

  def count_region(used, to_proceed \\ [], count \\ 0)
  def count_region([], _to_proceed, count), do: count
  def count_region([a | rest_used], [], count), do: count_region(rest_used, [a], count + 1)

  def count_region(used, [a | rest_to_proceed], count) do
    neight = Enum.filter(neightbours(a), &(&1 in used))

    count_region(used -- neight, rest_to_proceed ++ neight, count)
  end

  defp neightbours({x, y}), do: [{x - 1, y}, {x, y - 1}, {x + 1, y}, {x, y + 1}]

  def solution1(input) do
    input
    |> parser()
    |> build_grid()
    |> list_used()
    |> Enum.count()
  end

  def solution2(input) do
    input
    |> parser()
    |> build_grid()
    |> list_used()
    |> count_region()
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  8230
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part2()
  1103
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
  end
end
