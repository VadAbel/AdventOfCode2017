defmodule Aoc2017.Day21 do
  @moduledoc false

  @day "21"
  @input_file "../inputs/day#{@day}.txt"

  @start_image [~c".#.", ~c"..#", ~c"###"]

  def parser(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.flat_map(&parse_line(&1))
    |> Map.new()
  end

  def parse_line(line) do
    [input_pattern, output_pattern] =
      line
      |> String.split(" => ", trim: true)
      |> Enum.map(fn x ->
        String.split(x, "/", trim: true)
        |> Enum.map(&String.to_charlist(&1))
      end)

    input_pattern
    |> combinaisons()
    |> Enum.map(&{&1, output_pattern})
  end

  def combinaisons(pattern) do
    [pattern]
    |> Stream.iterate(fn [x | _] ->
      flip = Enum.reverse(x)
      rotate = Enum.zip_with(flip, & &1)

      [rotate, flip]
    end)
    |> Stream.drop(1)
    |> Stream.take(4)
    |> Enum.concat()
  end

  def enhance(image, rules) do
    pattern_size = if rem(length(image), 2) == 0, do: 2, else: 3

    image
    |> Enum.map(&Enum.chunk_every(&1, pattern_size))
    |> Enum.chunk_every(pattern_size)
    |> Enum.map(fn x ->
      Enum.zip_with(x, & &1)
      |> Enum.map(&rules[&1])
      |> Enum.zip_with(&(&1 |> Enum.concat()))
    end)
    |> Enum.concat()
  end

  def solution1(input, iteration \\ 5) do
    rules = parser(input)

    1..iteration
    |> Enum.reduce(
      @start_image,
      fn _, acc ->
        enhance(acc, rules)
      end
    )
    |> Enum.concat()
    |> Enum.count(&(&1 == ?#))
  end

  def solution2(input) do
    solution1(input, 18)
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  171
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part2()
  2498142
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
  end
end
