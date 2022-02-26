defmodule Aoc2017.Day07 do
  @day "07"
  @input_file "../inputs/day#{@day}.txt"

  defp parse(line) do
    [name, weight | disc] =
      line
      |> String.split([" ", "(", ")", "->", ","], trim: true)

    %{
      name: name,
      weight: weight |> String.to_integer(),
      disc: disc
    }
  end

  defp find_base(programs) do
    names = get_in(programs, [Access.all(), :name])
    discs = get_in(programs, [Access.all(), :disc]) |> List.flatten()

    Enum.reject(names, &(&1 in discs))
    |> hd()
  end

  defp find_unbalanced_tower({verified_towers, [tower | rest_towers]}) do
    if Enum.all?(tower[:disc], fn x -> x in get_in(verified_towers, [Access.all(), :name]) end) do
      check_tower(tower, {verified_towers, rest_towers})
    else
      find_unbalanced_tower({verified_towers, rest_towers ++ [tower]})
    end
  end

  defp check_tower(tower, {verified_towers, towers}) do
    group_tower_weight =
      tower[:disc]
      |> Enum.map(fn x ->
        {x, get_in(verified_towers, [Access.filter(&(&1.name == x)), :weight]) |> hd()}
      end)
      |> Enum.group_by(&elem(&1, 1), &elem(&1, 0))

    if map_size(group_tower_weight) == 1 do
      nb_tower = group_tower_weight |> Map.values() |> hd() |> Enum.count()
      weight_tower = group_tower_weight |> Map.keys() |> hd()

      find_unbalanced_tower({
        [
          %{tower | weight: tower.weight + nb_tower * weight_tower}
          | verified_towers
        ],
        towers
      })
    else
      {[{unbalanced_value, [unbalanced_tower]}], [{balanced_value, _}]} =
        group_tower_weight
        |> Enum.split_with(fn {_, x} -> Enum.count(x) == 1 end)

      {unbalanced_tower, unbalanced_value - balanced_value}
    end
  end

  def solution1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)
    |> find_base()
  end

  def solution2(input) do
    programs =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&parse/1)

    {tower, delta} =
      programs
      |> Enum.split_with(fn x -> x.disc == [] end)
      |> find_unbalanced_tower()

    (get_in(programs, [Access.filter(&(&1.name == tower)), :weight]) |> hd()) - delta
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  "gmcrj"
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part2()
  391
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
