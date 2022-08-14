defmodule Aoc2017.Day13 do
  @day "13"
  @input_file "../inputs/day#{@day}.txt"

  def parser(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn a ->
      String.split(a, ": ", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
  end

  def calc_severity(firewall, delay \\ 0) do
    firewall
    |> Enum.filter(&depth_intercepted?(&1, delay))
    |> Enum.map(&Tuple.product/1)
    |> Enum.sum()
  end

  def intercepted?(firewall, delay), do: Enum.any?(firewall, &depth_intercepted?(&1, delay))

  def depth_intercepted?({depth, range}, delay), do: rem(depth + delay, (range - 1) * 2) == 0

  def solution1(input) do
    input
    |> parser()
    |> calc_severity()
  end

  def solution2(input) do
    firewall = input |> parser()

    Stream.iterate(0, &(&1 + 1))
    |> Stream.drop_while(&intercepted?(firewall, &1))
    |> Enum.take(1)
    |> hd()
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  2160
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part2()
  3907470
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
