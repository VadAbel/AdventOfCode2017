defmodule Aoc2017.Day08 do
  @day "08"
  @input_file "../inputs/day#{@day}.txt"

  @start_register %{}

  defp parse(line) do
    [
      instruction_register,
      instruction_operator,
      instruction_value,
      _,
      test_register,
      test_operator,
      test_value
    ] =
      line
      |> String.split()

    {
      {instruction_register, instruction_operator, instruction_value |> String.to_integer()},
      {test_register, test_operator, test_value |> String.to_integer()}
    }
  end

  defp test?({r, o, v}, register) do
    case o do
      ">=" -> Map.get(register, r, 0) >= v
      ">" -> Map.get(register, r, 0) > v
      "<" -> Map.get(register, r, 0) < v
      "<=" -> Map.get(register, r, 0) <= v
      "==" -> Map.get(register, r, 0) == v
      "!=" -> Map.get(register, r, 0) != v
    end
  end

  defp exec({r, o, v}, register) do
    case o do
      "inc" -> Map.update(register, r, v, &(&1 + v))
      "dec" -> Map.update(register, r, -v, &(&1 - v))
    end
  end

  defp check_max(register, {r, _o, _v}, nil), do: {register, register[r]}
  defp check_max(register, {r, _o, _v}, max_value), do: {register, max(max_value, register[r])}

  def solution1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse(&1))
    |> Enum.reduce(@start_register, fn {instruction, test}, register ->
      case test?(test, register) do
        true -> exec(instruction, register)
        _ -> register
      end
    end)
    |> Map.values()
    |> Enum.max()
  end

  def solution2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse(&1))
    |> Enum.reduce({@start_register, nil}, fn {instruction, test}, {register, max_value} ->
      case test?(test, register) do
        true -> exec(instruction, register) |> check_max(instruction, max_value)
        _ -> {register, max_value}
      end
    end)
    |> elem(1)
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  3089
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part2()
  5391
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
