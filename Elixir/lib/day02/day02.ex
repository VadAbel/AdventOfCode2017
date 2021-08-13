defmodule Aoc2017.Day02 do
  @day "02"
  @input_file "../inputs/day#{@day}.txt"

  defp parser(line) do
    line
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end

  def solution1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, acc ->
      {mini, maxi} =
        line
        |> parser()
        |> Enum.min_max()

      maxi - mini + acc
    end)
  end

  def solution2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn
      line, acc ->
        row = parser(line)

        for x <- row,
            y <- row -- [x],
            rem(x, y) == 0,
            reduce: acc,
            do: (acc -> div(x, y) + acc)
    end)
  end

  @doc """
  iex> Aoc2017.Day02.part1()
  44887
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2017.Day02.part2()
  242
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
