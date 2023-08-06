defmodule Mix.Tasks.Gen do
  @moduledoc false
  use Mix.Task

  def run(args) do
    case OptionParser.parse(args, strict: []) do
      {[], [day], []} -> Aoc2017.gen(day)
      _ -> IO.puts("Invalid Arguments")
    end
  end
end
