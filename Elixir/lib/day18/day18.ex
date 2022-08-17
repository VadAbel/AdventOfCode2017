defmodule Aoc2017.Day18 do
  @day "18"
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

  def parse_operand(operand = <<a, _rest::binary()>>) when a in ?a..?z,
    do: String.to_atom(operand)

  def parse_operand(operand), do: String.to_integer(operand)

  def value(operand, _register) when is_integer(operand), do: operand
  def value(operand, register), do: Map.get(register, operand, 0)

  def exec(nil, register) do
    {:halt, register |> Map.put(:pointer, :halt), []}
  end

  def exec({:snd, operand}, register) do
    val = value(operand, register)

    {
      :ok,
      Map.put(register, :snd, val)
      |> Map.update!(:pointer, &(&1 + 1)),
      [val]
    }
  end

  def exec({:set, operand_1, operand_2}, register) do
    {
      :ok,
      Map.put(register, operand_1, value(operand_2, register))
      |> Map.update!(:pointer, &(&1 + 1)),
      []
    }
  end

  def exec({:add, operand_1, operand_2}, register) do
    {
      :ok,
      Map.update(
        register,
        operand_1,
        value(operand_2, register),
        &(&1 + value(operand_2, register))
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
      |> Map.update!(:pointer, &(&1 + 1)),
      []
    }
  end

  def exec({:mod, operand_1, operand_2}, register) do
    {
      :ok,
      Map.update(
        register,
        operand_1,
        0,
        &rem(&1, value(operand_2, register))
      )
      |> Map.update!(:pointer, &(&1 + 1)),
      []
    }
  end

  # rcv for part2
  def exec({:rcv, operand}, register) when is_map_key(register, :stack) do
    case register.stack do
      [] ->
        {:wait, register, []}

      [h | t] ->
        {
          :ok,
          register
          |> Map.put(operand, h)
          |> Map.put(:stack, t)
          |> Map.update!(:pointer, &(&1 + 1)),
          []
        }
    end
  end

  # :rcv for part 1
  def exec({:rcv, operand}, register) do
    if(value(operand, register) != 0) do
      {
        :rcv,
        Map.put(register, operand, value(:snd, register))
        |> Map.update!(:pointer, &(&1 + 1)),
        []
      }
    else
      {
        :ok,
        register |> Map.update!(:pointer, &(&1 + 1)),
        []
      }
    end
  end

  def exec({:jgz, operand_1, operand_2}, register) do
    if(value(operand_1, register) > 0,
      do: {:ok, Map.update!(register, :pointer, &(&1 + value(operand_2, register))), []},
      else: {:ok, Map.update!(register, :pointer, &(&1 + 1)), []}
    )
  end

  def process(instructions, register) do
    case exec(instructions[register.pointer], register) do
      {:rcv, new_register, _} -> Map.get(new_register, :snd, 0)
      {:halt, new_register, _} -> new_register
      {:ok, new_register, _} -> process(instructions, new_register)
    end
  end

  def process2(instructions, [register_0, register_1], {state_0, state_1}, count)
      when state_0 == :ok or state_1 == :ok do
    {new_state_0, new_register_0, msg_0} = exec(instructions[register_0.pointer], register_0)
    {new_state_1, new_register_1, msg_1} = exec(instructions[register_1.pointer], register_1)

    process2(
      instructions,
      [
        Map.update!(new_register_0, :stack, &(&1 ++ msg_1)),
        Map.update!(new_register_1, :stack, &(&1 ++ msg_0))
      ],
      {new_state_0, new_state_1},
      count + length(msg_1)
    )
  end

  def process2(_instructions, [_register_0, _register_1], {_state_0, _state_1}, count), do: count

  def solution1(input) do
    input
    |> parser()
    |> process(%{pointer: 0})
  end

  def solution2(input) do
    input
    |> parser()
    |> process2([%{pointer: 0, p: 0, stack: []}, %{pointer: 0, p: 1, stack: []}], {:ok, :ok}, 0)
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  9423
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part2()
  7620
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
