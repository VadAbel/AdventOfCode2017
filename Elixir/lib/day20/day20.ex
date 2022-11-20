defmodule Aoc2017.Day20 do
  @day "20"
  @input_file "../inputs/day#{@day}.txt"

  def parser(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index(fn item, idx -> {idx, parse_line(item)} end)
    |> Map.new()
  end

  def parse_line(line) do
    line
    |> String.split(", ", trim: true)
    |> Enum.map(fn item ->
      [type, vector] = String.split(item, "=", trim: true)

      {String.to_atom(type), parse_vector(vector)}
    end)
    |> Map.new()
  end

  def parse_vector(vector) do
    vector
    |> String.split(["<", ",", ">", " "], trim: true)
    |> Enum.map(&String.to_integer(&1))
  end

  def manhattan(vector) do
    vector
    |> Enum.map(&abs/1)
    |> Enum.sum()
  end

  def keep_min_by(particules, item) do
    min_acceleration =
      particules
      |> Map.values()
      |> Enum.map(fn particule ->
        manhattan(particule[item])
      end)
      |> Enum.min()

    Map.filter(particules, fn {_key, value} -> manhattan(value[item]) == min_acceleration end)
  end

  def vectors_add(vectors, item_1, item_2) do
    Map.update!(
      vectors,
      item_1,
      &Enum.zip_with(&1, vectors[item_2], fn a, b -> a + b end)
    )
  end

  def simulate(particules) do
    particules
    |> Enum.map(fn {key, vectors} ->
      {key,
       vectors
       |> vectors_add(:v, :a)
       |> vectors_add(:p, :v)}
    end)
    |> Map.new()
  end

  def simulate_to_stab(particules, collision \\ false) do
    new_particules =
      if collision,
        do: simulate(particules) |> detect_collision(),
        else: simulate(particules)

    if Enum.any?(new_particules, fn {key, vectors} ->
         (manhattan(vectors[:v]) <= manhattan(particules[key][:v]) && manhattan(vectors[:a]) != 0) ||
           manhattan(vectors[:p]) < manhattan(particules[key][:p])
       end),
       do: simulate_to_stab(new_particules, collision),
       else: particules
  end

  def detect_collision(particules) do
    positions =
      Map.values(particules)
      |> get_in([Access.all(), :p])

    Map.filter(particules, fn {_key, vectors} ->
      Enum.count(positions, fn p -> p == vectors[:p] end) == 1
    end)
  end

  def solution1(input) do
    input
    |> parser()
    |> keep_min_by(:a)
    |> simulate_to_stab()
    |> keep_min_by(:v)
    |> keep_min_by(:p)
    |> Map.keys()
    |> hd()
  end

  def solution2(input) do
    input
    |> parser()
    |> simulate_to_stab(true)
    |> map_size()
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part1()
  119
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2017.Day#{@day}.part2()
  471
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
