defmodule Aoc2017.Day06 do
  @moduledoc false

  @day "06"
  @input_file "../inputs/day#{@day}.txt"

  defp find_block(bank), do: find_block(bank, MapSet.new() |> MapSet.put(bank))

  defp find_block(bank, state) do
    {max_block, value} =
      bank
      |> Enum.sort_by(&elem(&1, 0), :asc)
      |> Enum.sort_by(&elem(&1, 1), :desc)
      |> hd()

    reallocation(%{bank | max_block => 0}, state, max_block + 1, value)
  end

  defp reallocation(bank, state, _block, 0), do: save_state(bank, state)

  defp reallocation(bank, state, block, value) when block >= map_size(bank),
    do: reallocation(bank, state, 0, value)

  defp reallocation(bank, state, block, value) do
    reallocation(
      update_in(bank[block], &(&1 + 1)),
      state,
      block + 1,
      value - 1
    )
  end

  defp save_state(bank, state) do
    case MapSet.member?(state, bank) do
      true -> {bank, MapSet.size(state)}
      false -> find_block(bank, state |> MapSet.put(bank))
    end
  end

  def solution1(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index(fn element, index -> {index, element} end)
    |> Map.new()
    |> find_block()
    |> elem(1)
  end

  def solution2(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index(fn element, index -> {index, element} end)
    |> Map.new()
    |> find_block()
    |> elem(0)
    |> find_block()
    |> elem(1)
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  12841
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part2()
  8038
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
  end
end
