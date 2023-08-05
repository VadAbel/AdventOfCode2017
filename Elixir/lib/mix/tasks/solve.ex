defmodule Mix.Tasks.Solve do
  @moduledoc false
  use Mix.Task

  def run(args) do
    case OptionParser.parse(args, aliases: [p: :part], strict: [part: :integer]) do
      {[], [], []} -> Aoc2017.solve_all()
      {[], [day], []} -> Aoc2017.solve(day)
      {[part: part], [day], []} when part in 1..2 -> Aoc2017.solve(day, [part])
      _ -> IO.puts("Invalid Arguments")
    end
  end
end
