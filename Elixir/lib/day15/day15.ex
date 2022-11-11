defmodule Aoc2017.Day15 do
  @day "15"
  @input_file "../inputs/day#{@day}.txt"

  import Bitwise

  @factor [16807, 48271]
  @divisor 2_147_483_647
  @mask 0xFFFF

  def parser(input) do
    %{"A" => a, "B" => b} =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(
        &(String.split(&1, ["Generator ", " starts with "], trim: true)
          |> List.to_tuple())
      )
      |> Map.new()

    [a, b]
    |> Enum.map(&String.to_integer/1)
  end

  def pair_match?({a, b}) do
    (a &&& @mask) == (b &&& @mask)
  end

  def generator(val, factor) do
    Stream.unfold(val, fn val -> {val, (val * factor) |> rem(@divisor)} end)
    |> Stream.drop(1)
  end

  def generator(val, factor, multiple) do
    generator(val, factor)
    |> Stream.filter(fn val -> rem(val, multiple) == 0 end)
  end

  def create_generator(pair) do
    [pair, @factor]
    |> Enum.zip_with(fn [a, f] -> generator(a, f) end)
    |> Stream.zip()
  end

  def create_generator(pair, multiples) do
    [pair, @factor, multiples]
    |> Enum.zip_with(fn [a, f, m] -> generator(a, f, m) end)
    |> Stream.zip()
  end

  def solution1(input) do
    input
    |> parser()
    |> create_generator()
    |> Stream.take(40_000_000)
    |> Stream.filter(fn pair -> pair_match?(pair) end)
    |> Enum.count()
  end

  def solution2(input) do
    input
    |> parser()
    |> create_generator([4, 8])
    |> Stream.take(5_000_000)
    |> Stream.filter(fn pair -> pair_match?(pair) end)
    |> Enum.count()
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  597
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part2()
  303
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
