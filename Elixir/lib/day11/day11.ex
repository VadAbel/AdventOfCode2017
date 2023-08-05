defmodule Aoc2017.Day11 do
  @moduledoc false

  @day "11"
  @input_file "../inputs/day#{@day}.txt"

  @direction_step %{
    "n" => {0, 2},
    "ne" => {1, 1},
    "se" => {1, -1},
    "s" => {0, -2},
    "sw" => {-1, -1},
    "nw" => {-1, 1}
  }

  def parser(input) do
    String.split(input, ",", trim: true)
  end

  def step(dir, {x, y}) do
    {x_step, y_step} = @direction_step[dir]
    {x + x_step, y + y_step}
  end

  def calc_distance({x, y}) do
    div(abs(x) + abs(y), 2)
  end

  def solution1(input) do
    input
    |> parser()
    |> Enum.reduce({0, 0}, &step(&1, &2))
    |> calc_distance()
  end

  def solution2(input) do
    input
    |> parser()
    |> Enum.scan({0, 0}, &step(&1, &2))
    |> Enum.map(&calc_distance(&1))
    |> Enum.max()
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  764
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part2()
  1532
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
  end
end
