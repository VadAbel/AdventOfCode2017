defmodule Aoc2017.Day04 do
  @day "04"
  @input_file "../inputs/day#{@day}.txt"

  def solution1(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.filter(&(&1 == Enum.uniq(&1)))
    |> Enum.count()
  end

  def solution2(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(fn password ->
      for first <- password,
          second <- password -- [first],
          first_split = String.codepoints(first),
          second_split = String.codepoints(second),
          first_split -- second_split == [],
          second_split -- first_split == [],
          do: false
    end)
    |> Enum.filter(&(&1 == []))
    |> Enum.count()
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  386
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part2()
  208
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
