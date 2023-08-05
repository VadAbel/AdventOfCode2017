defmodule Aoc2017.Day19 do
  @moduledoc false

  @day "19"
  @input_file "../inputs/day#{@day}.txt"

  def parser(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index(fn line, y ->
      line
      |> String.to_charlist()
      |> Enum.with_index(fn item, x -> {{x, y}, item} end)
    end)
    |> Enum.concat()
    |> Enum.reject(fn {_coord, item} -> item == ?\s end)
    |> Map.new()
  end

  def find_start(diagram) do
    diagram
    |> Map.keys()
    |> Enum.find(fn {_x, y} -> y == 0 end)
  end

  def move({pos_x, pos_y}, {dir_x, dir_y}), do: {pos_x + dir_x, pos_y + dir_y}

  def change_direction(diagram, position) do
    [{-1, 0}, {0, -1}, {1, 0}, {0, 1}]
    |> Enum.filter(&Map.has_key?(diagram, move(position, &1)))
    |> hd()
  end

  def travel(diagram), do: travel(diagram, find_start(diagram), {0, 1}, [], 0)

  def travel(diagram, _position, _direction, message, step) when map_size(diagram) == 0,
    do: {
      message
      |> Enum.reverse()
      |> List.to_string(),
      step
    }

  def travel(diagram, position, direction, message, step) do
    {value, new_diagram} = Map.pop(diagram, position)

    new_message = if value in ?A..?Z, do: [value | message], else: message
    new_direction = if value == ?+, do: change_direction(new_diagram, position), else: direction
    new_position = move(position, new_direction)

    travel(new_diagram, new_position, new_direction, new_message, step + 1)
  end

  def solution1(input) do
    input
    |> parser()
    |> travel()
    |> elem(0)
  end

  def solution2(input) do
    input
    |> parser()
    |> travel()
    |> elem(1)
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  "VTWBPYAQFU"
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part2()
  17358
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
  end
end
