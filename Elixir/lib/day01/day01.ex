defmodule Aoc2017.Day01 do
  @moduledoc false

  @day "01"
  @input_file "../inputs/day#{@day}.txt"

  defp parser(input) do
    input
    |> String.codepoints()
    |> Enum.map(&String.to_integer/1)
  end

  defp return_same([x, x]), do: x
  defp return_same([_x, _y]), do: 0

  def solution1(input) do
    captcha = parser(input)

    captcha
    |> Stream.chunk_every(2, 1, [hd(captcha)])
    |> Enum.reduce(0, &(return_same(&1) + &2))
  end

  def solution2(input) do
    captcha = parser(input)

    captcha
    |> Stream.chunk_every(div(length(captcha), 2))
    |> Enum.zip_reduce(0, &(return_same(&1) * 2 + &2))
  end

  @doc """
  iex> Aoc2017.Day01.part1()
  1341
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
  end

  @doc """
  iex> Aoc2017.Day01.part2()
  1348
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
  end
end
