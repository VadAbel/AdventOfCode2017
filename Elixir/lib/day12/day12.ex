defmodule Aoc2017.Day12 do
  @day "12"
  @input_file "../inputs/day#{@day}.txt"

  def parser(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn x ->
      String.split(x, ["<->", ",", " "], trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
    |> Map.new(fn [a | b] -> {a, b} end)
  end

  def process(programs, [], processed),
    do: {length(processed), programs}

  def process(programs, [a | _] = to_process, processed) do
    {list_programs, new_programs} = Map.pop(programs, a, [])
    new_processed = [a | processed]

    new_to_process = ((to_process ++ list_programs) |> Enum.uniq()) -- new_processed

    process(new_programs, new_to_process, new_processed)
  end

  def process2(programs) when map_size(programs) == 0, do: 0

  def process2(programs) do
    a = programs |> Map.keys() |> hd()

    1 +
      (process(programs, [a], [])
       |> elem(1)
       |> process2())
  end

  def solution1(input) do
    input
    |> parser()
    |> process([0], [])
    |> elem(0)
  end

  def solution2(input) do
    input
    |> parser()
    |> process2()
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  113
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part2()
  202
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
