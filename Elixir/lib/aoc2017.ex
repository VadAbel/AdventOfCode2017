defmodule Aoc2017 do
  @moduledoc """
  Documentation for `Aoc2017`.
  """

  def solve_all() do
    1..25
    |> Enum.each(&solve(Integer.to_string(&1)))
  end

  def solve(day, parts \\ [1, 2]) do
    run_day = String.pad_leading(day, 2, "0")
    module_day = Module.concat(__MODULE__, "Day#{run_day}")

    IO.puts("Solve Day #{day}")

    case Code.ensure_loaded(module_day) do
      {:module, _} ->
        parts
        |> Enum.each(fn part ->
          result = Function.capture(module_day, String.to_existing_atom("part#{part}"), 0).()

          IO.puts("Day #{day} part #{part} : #{result}")
        end)

      _ ->
        IO.puts("Day #{day} not defined")
    end

    IO.puts("---")
  end
end
