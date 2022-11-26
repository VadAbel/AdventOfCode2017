defmodule Aoc2017.Day23 do
  @day "23"
  @input_file "../inputs/day#{@day}.txt"

  def parser(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line(&1))
    |> Enum.with_index(&{&2, &1})
    |> Map.new()
  end

  def parse_line(line) do
    line
    |> String.split(" ", trim: true)
    |> List.update_at(0, &String.to_atom/1)
    |> List.update_at(1, &parse_operand/1)
    |> List.update_at(2, &parse_operand/1)
    |> List.to_tuple()
  end

  def parse_operand(operand = <<a, _rest::binary>>) when a in ?a..?z,
    do: String.to_atom(operand)

  def parse_operand(operand), do: String.to_integer(operand)

  def value(operand, _register) when is_integer(operand), do: operand
  def value(operand, register), do: Map.get(register, operand, 0)

  def exec(nil, register) do
    {:halt, register |> Map.put(:pointer, :halt), []}
  end

  def exec({:set, operand_1, operand_2}, register) do
    {
      :ok,
      Map.put(register, operand_1, value(operand_2, register))
      |> Map.update!(:pointer, &(&1 + 1)),
      []
    }
  end

  def exec({:sub, operand_1, operand_2}, register) do
    {
      :ok,
      Map.update(
        register,
        operand_1,
        value(operand_2, register),
        &(&1 - value(operand_2, register))
      )
      |> Map.update!(:pointer, &(&1 + 1)),
      []
    }
  end

  def exec({:mul, operand_1, operand_2}, register) do
    {
      :ok,
      Map.update(
        register,
        operand_1,
        0,
        &(&1 * value(operand_2, register))
      )
      |> then(fn
        x ->
          if Map.has_key?(x, :mul), do: Map.update!(x, :mul, &(&1 + 1)), else: x
      end)
      |> Map.update!(:pointer, &(&1 + 1)),
      []
    }
  end

  def exec({:jnz, operand_1, operand_2}, register) do
    if(value(operand_1, register) != 0,
      do: {:ok, Map.update!(register, :pointer, &(&1 + value(operand_2, register))), []},
      else: {:ok, Map.update!(register, :pointer, &(&1 + 1)), []}
    )
  end

  def process(instructions, register) do
    case exec(instructions[register.pointer], register) do
      {:halt, new_register, _} -> new_register
      {:ok, new_register, _} -> process(instructions, new_register)
    end
  end

  def solution1(input) do
    input
    |> parser()
    |> process(%{pointer: 0, mul: 0})
    |> Map.get(:mul)
  end

  def solution2(_input) do
    b = 84 * 100 + 100_000
    c = b + 17000

    b..c//17
    |> Enum.count(fn x ->
      2..floor(:math.sqrt(x))
      |> Enum.any?(&(rem(x, &1) == 0))
    end)
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  6724
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part2()
  903
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
