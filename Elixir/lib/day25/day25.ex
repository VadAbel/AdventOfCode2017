defmodule Aoc2017.Day25 do
  @day "25"
  @input_file "../inputs/day#{@day}.txt"

  def solution1(input) do
    input
  end

  def solution2(input) do
    input
  end

  # @doc """
  # iex> Aoc2017.Day#{@day}.part1()
  # nil
  # """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  # @doc """
  # iex> Aoc2017.Day#{@day}.part2()
  # 479010245
  # """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
