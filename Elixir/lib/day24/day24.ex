defmodule Aoc2017.Day24 do
  @moduledoc false

  @day "24"
  @input_file "../inputs/day#{@day}.txt"

  @start_port 0

  def parser(input) do
    input
    |> String.split(["\n"], trim: true)
    |> Enum.map(fn line ->
      String.split(line, ["/"], trim: true)
      |> Enum.map(&String.to_integer(&1))
    end)
  end

  def possible_components(components, port), do: Enum.filter(components, &(port in &1))

  def make_bridge(components, port),
    do: make_bridge(components, possible_components(components, port), port)

  def make_bridge(_components, [], _port), do: [[]]

  def make_bridge(components, possible, port) do
    for component <- possible,
        new_components = components -- [component],
        new_port = (component -- [port]) |> hd(),
        rest <- make_bridge(new_components, new_port),
        do: [component | rest]
  end

  def longest_bridges(bridges) do
    max_length =
      bridges
      |> Enum.map(&length(&1))
      |> Enum.max()

    Enum.filter(bridges, &(length(&1) == max_length))
  end

  def solution1(input) do
    input
    |> parser()
    |> make_bridge(@start_port)
    |> Enum.map(&(List.flatten(&1) |> Enum.sum()))
    |> Enum.max()
  end

  def solution2(input) do
    input
    |> parser()
    |> make_bridge(@start_port)
    |> longest_bridges()
    |> Enum.map(&(List.flatten(&1) |> Enum.sum()))
    |> Enum.max()
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  1868
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part2()
  1841
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
  end
end
