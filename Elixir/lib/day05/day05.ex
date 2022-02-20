defmodule Aoc2017.Day05 do
  @day "05"
  @input_file "../inputs/day#{@day}.txt"

  defp jump(jump_map, inc_func, position \\ 0, step \\ 0)

  defp jump(jump_map, _inc_func, position, step)
       when position < 0 or position >= map_size(jump_map),
       do: step

  defp jump(jump_map, inc_func, position, step) do
    {jump_value, new_jump_map} = get_and_update_in(jump_map[position], &{&1, inc_func.(&1)})

    jump(new_jump_map, inc_func, position + jump_value, step + 1)
  end

  def solution1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index(fn element, index -> {index, element} end)
    |> Map.new()
    |> jump(fn val -> val + 1 end)
  end

  def solution2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index(fn element, index -> {index, element} end)
    |> Map.new()
    |> jump(fn
      val when val >= 3 -> val - 1
      val -> val + 1
    end)
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  374269
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part2()
  27720699
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
