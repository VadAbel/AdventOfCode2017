defmodule Aoc2017.Day16 do
  @moduledoc false

  @day "16"
  @input_file "../inputs/day#{@day}.txt"

  def parser(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(&(String.split_at(&1, 1) |> parse_instruction))
  end

  def parse_instruction({"s", operand}), do: {?s, String.to_integer(operand)}

  def parse_instruction({"x", operand}),
    do: {
      ?x,
      String.split(operand, "/", trim: true) |> Enum.map(&String.to_integer/1) |> Enum.sort()
    }

  def parse_instruction({"p", operand}),
    do: {
      ?p,
      String.split(operand, "/", trim: true)
      |> Enum.map(&(String.to_charlist(&1) |> hd()))
    }

  def exec(programs, {?s, count}), do: Enum.slide(programs, -count..-1, 0)

  def exec(programs, {?x, [idx1, idx2]}) do
    {val2, programs2} = List.pop_at(programs, idx2)
    {val1, programs1} = List.pop_at(programs2, idx1)

    List.insert_at(programs1, idx1, val2)
    |> List.insert_at(idx2, val1)
  end

  def exec(programs, {?p, [val1, val2]}),
    do:
      exec(
        programs,
        {?x,
         [val1, val2]
         |> Enum.map(&Enum.find_index(programs, fn x -> x == &1 end))
         |> Enum.sort()}
      )

  def dance(instructions, programs),
    do: Enum.reduce(instructions, programs, fn instruction, acc -> exec(acc, instruction) end)

  def dance_loop(_instructions, programs, {time, limit_time}, _save) when time == limit_time,
    do: programs

  def dance_loop(_instructions, programs, {time, limit_time}, save)
      when is_map_key(save, programs),
      do:
        Map.filter(save, fn {_key, value} -> value == rem(limit_time, time) end)
        |> Map.keys()
        |> hd()

  def dance_loop(instructions, programs, {time, limit_time}, save),
    do:
      dance_loop(
        instructions,
        dance(instructions, programs),
        {time + 1, limit_time},
        Map.put(save, programs, time)
      )

  def solution1(input, programs \\ ?a..?p) do
    input
    |> parser()
    |> dance(programs |> Enum.to_list())
    |> List.to_string()
  end

  def solution2(input, programs \\ ?a..?p, time \\ 1_000) do
    input
    |> parser()
    |> dance_loop(programs |> Enum.to_list(), {0, time}, %{})
    |> List.to_string()
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  "namdgkbhifpceloj"
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part2()
  "ibmchklnofjpdeag"
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
  end
end
