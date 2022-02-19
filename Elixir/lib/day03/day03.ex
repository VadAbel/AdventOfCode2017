defmodule Aoc2017.Day03 do
  @day "03"
  @input_file "../inputs/day#{@day}.txt"

  @start_position {0, 0}
  @start_direction {1, 0}
  @start_value 1

  defp turn({x, y}), do: {-y, x}

  defp next_direction(direction, {position_x, position_y})
       when abs(position_x) == abs(position_y) and not (position_x >= 0 and position_y <= 0),
       do: turn(direction)

  defp next_direction(direction, {position_x, position_y})
       when position_x == -position_y + 1 and (position_x >= 0 and position_y <= 0),
       do: turn(direction)

  defp next_direction(direction, {_position_x, _position_y}), do: direction

  defp next_position({position_x, position_y}, {direction_x, direction_y}),
    do: {position_x + direction_x, position_y + direction_y}

  defp neigh({x, y}) do
    [
      {x - 1, y + 1},
      {x - 1, y},
      {x - 1, y - 1},
      {x, y + 1},
      {x, y - 1},
      {x + 1, y - 1},
      {x + 1, y},
      {x + 1, y + 1}
    ]
  end

  defp next({position, direction}) do
    new_position = next_position(position, direction)
    new_direction = next_direction(direction, new_position)

    {new_position, new_direction}
  end

  defp next({_value, position, direction, position_map}) do
    new_position = next_position(position, direction)
    new_direction = next_direction(direction, new_position)

    new_value =
      position_map
      |> Map.take(neigh(new_position))
      |> Map.values()
      |> Enum.sum()

    {new_value, new_position, new_direction, Map.put(position_map, new_position, new_value)}
  end

  defp distance({x1, y1}, {x2, y2}),
    do: abs(x1 - x2) + abs(y1 - y2)

  def solution1(input) do
    mark =
      input
      |> String.to_integer()

    {@start_position, @start_direction}
    |> Stream.iterate(&next/1)
    |> Enum.at(mark - 1)
    |> elem(0)
    |> distance(@start_position)
  end

  def solution2(input) do
    mark =
      input
      |> String.to_integer()

    {@start_value, @start_position, @start_direction, %{@start_position => @start_value}}
    |> Stream.iterate(&next/1)
    |> Stream.drop_while(fn {value, _, _, _} -> value < mark end)
    |> Enum.at(0)
    |> elem(0)
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  480
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part2()
  349975
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
