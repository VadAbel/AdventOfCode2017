defmodule Aoc2017.Day22 do
  @day "22"
  @input_file "../inputs/day#{@day}.txt"

  @start_dir {0, -1}

  def parser(input) do
    start_nodes =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_charlist(&1))

    start_pos =
      [Enum.at(start_nodes, 0), start_nodes]
      |> Enum.map(&(&1 |> length() |> div(2)))
      |> List.to_tuple()

    infected =
      start_nodes
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, y} ->
        Enum.with_index(line, fn
          ?., x -> {{x, y}, :clean}
          ?#, x -> {{x, y}, :infected}
        end)
      end)
      |> Map.new()

    {start_pos, @start_dir, infected}
  end

  def burst({{pos, dir, nodes}, infection}, evolve_fn) do
    {state, new_nodes} =
      get_and_update_in(nodes, [Access.key(pos, :clean)], &{&1, evolve_fn.(&1)})

    new_infection =
      if new_nodes[pos] == :infected,
        do: infection + 1,
        else: infection

    new_dir = turn(dir, state)
    new_pos = move(pos, new_dir)

    {{new_pos, new_dir, new_nodes}, new_infection}
  end

  def turn({x, y}, :infected), do: {-y, x}
  def turn({x, y}, :clean), do: {y, -x}
  def turn({x, y}, :weakened), do: {x, y}
  def turn({x, y}, :flagged), do: {-x, -y}

  def move({pos_x, pos_y}, {dir_x, dir_y}), do: {pos_x + dir_x, pos_y + dir_y}
  def evolve_1(:clean), do: :infected
  def evolve_1(:infected), do: :clean

  def evolve_2(:clean), do: :weakened
  def evolve_2(:weakened), do: :infected
  def evolve_2(:infected), do: :flagged
  def evolve_2(:flagged), do: :clean

  def solution1(input, burst \\ 10000) do
    1..burst
    |> Enum.reduce({parser(input), 0}, fn _, acc -> burst(acc, &evolve_1/1) end)
    |> elem(1)
  end

  def solution2(input, burst \\ 10_000_000) do
    1..burst
    |> Enum.reduce({parser(input), 0}, fn _, acc -> burst(acc, &evolve_2/1) end)
    |> elem(1)
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  5552
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part2()
  2511527
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
