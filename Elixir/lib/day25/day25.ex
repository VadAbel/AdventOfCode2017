defmodule Aoc2017.Day25 do
  @day "25"
  @input_file "../inputs/day#{@day}.txt"

  def parser(input) do
    [begin | states] =
      input
      |> String.split(["\n\n"])

    [start, steps] =
      begin
      |> String.split(
        ["\n", ".", " ", "Begin in state", "Perform a diagnostic checksum after", "steps"],
        trim: true
      )

    states_instractions =
      states
      |> Enum.map(&parse_state(&1))
      |> Map.new()

    {start, String.to_integer(steps), states_instractions}
  end

  def parse_state(state_instructions) do
    [state | instructions] =
      state_instructions
      |> String.split("\n", trim: true)

    {
      state
      |> String.split(["In state ", ":"], trim: true)
      |> hd(),
      instructions
      |> Enum.chunk_every(4)
      |> Enum.map(&parse_instruction(&1))
      |> Map.new()
    }
  end

  def parse_instruction(instuction) do
    [value, write, move, continue] =
      instuction
      |> Enum.map(
        &String.split(
          &1,
          [
            "If the current value is",
            ":",
            "- Write the value",
            ".",
            "- Move one slot to the",
            "- Continue with state",
            " "
          ],
          trim: true
        )
      )
      |> Enum.concat()

    {
      String.to_integer(value),
      %{
        write: String.to_integer(write),
        move: if(move == "right", do: 1, else: -1),
        continue: continue
      }
    }
  end

  def exec({_state, 0, _states_instructions}, tape, _position), do: checksum(tape)

  def exec({state, steps, states_instructions}, tape, position) do
    new_tape = update_in(tape, [Access.key(position, 0)], &states_instructions[state][&1][:write])
    new_position = position + states_instructions[state][Map.get(tape, position, 0)][:move]
    new_state = states_instructions[state][Map.get(tape, position, 0)][:continue]

    exec({new_state, steps - 1, states_instructions}, new_tape, new_position)
  end

  def checksum(tape) do
    tape
    |> Map.values()
    |> Enum.sum()
  end

  def solution1(input) do
    input
    |> parser()
    |> exec(%{}, 0)
  end

  def solution2(input) do
    input
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  3578
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  # @doc """
  # iex> Aoc2017.Day#{@day}.part2()
  # 479010245
  # """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
