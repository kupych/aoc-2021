defmodule Aoc.Day1 do
  @moduledoc """
  Solutions for Day 1.
  """
  @behaviour Aoc.Day

  alias Aoc.Day

  @impl Day
  def day(), do: 1

  @impl Day
  def a(depths) do
    number_of_increases(depths)
  end

  @impl Day
  def b(first) do
    [_ | second] = first
    [_ | third] = second

      [first, second, third]
      |> Enum.zip_with(& &1)
      |> Enum.map(&Enum.sum/1)
      |> number_of_increases()
  end

  @impl Day
  def parse_input() do
    with {:ok, file} <- Day.load(__MODULE__) do
      file
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)
    end
  end

  @doc """
  `number_of_increases/1` takes a list of integers and
  finds the number of times a value increases from its
  previous value.
  """
  def number_of_increases([_ | _] = values) do
    prev_values = [nil | values]

    values
    |> Enum.zip(prev_values)
    |> Enum.map(fn
      {current, nil} -> current
      {current, prev} -> current - prev end)
    |> Enum.count(fn diff -> diff > 0 end)
end
