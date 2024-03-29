defmodule Aoc.Day15 do
  @moduledoc """
  Solutions for Day 15.
  """
  @behaviour Aoc.Day

  alias Aoc.Day

  @impl Day
  def day(), do: 15

  @impl Day
  def a(map) do
    find_path([{0, 0, 0}], map, %{}, length(map), length(Enum.at(map, 0)), 1) - Enum.at(Enum.at(map, 0), 0)
  end

  @impl Day
  def b(map) do
    find_path([{0, 0, 0}], map, %{}, length(map), length(Enum.at(map, 0)), 5) - Enum.at(Enum.at(map, 0), 0)
  end

  @impl Day
  def parse_input() do
    with {:ok, file} <- Day.load(__MODULE__) do
      file
      |> String.split("\n", trim: true)
    |> Enum.map(&(String.to_charlist(&1) |> Enum.map(fn v -> v - ?0 end)))
    end
  end

  def find_path([{_risk_level, row, column} | pqueue], data, cache, row_size, column_size, n)
      when row < 0 or row >= row_size * n or column < 0 or column >= column_size * n do
    find_path(pqueue, data, cache, row_size, column_size, n)
  end

  def find_path([{risk_level, row, column} | pqueue], data, cache, row_size, column_size, n) do
    total_risk =
      Enum.at(Enum.at(data, rem(row, row_size)), rem(column, column_size)) + div(row, row_size) +
        div(column, column_size)

    total_risk =
      if total_risk > 9,
        do: risk_level + rem(total_risk, 9),
        else: risk_level + total_risk

    if Map.get(cache, {row, column}) > total_risk do
      cache = Map.update(cache, {row, column}, total_risk, fn _ -> total_risk end)

      if row == row_size * n - 1 and column == column_size * n - 1 do
        Map.get(cache, {row, column})
      else
        pqueue =
          pqueue ++
            (Enum.map([[-1, 0], [0, 1], [1, 0], [0, -1]], fn [x, y] ->
               {Map.get(cache, {row, column}), row + x, column + y}
             end)
             |> Enum.reject(fn {_, o, p} -> Map.get(cache, {o, p}) end))

        find_path(Enum.sort(pqueue), data, cache, row_size, column_size, n)
      end
    else
      find_path(pqueue, data, cache, row_size, column_size, n)
    end
  end
end
