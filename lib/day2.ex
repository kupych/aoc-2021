defmodule Aoc.Day2 do
  @moduledoc """
  Solutions for Day 2.
  """
  @behaviour Aoc.Day

  alias Aoc.Day

  @impl Day
  def day(), do: 2

  @impl Day
  def a(instructions) do
    instructions
    |> Enum.reduce([0, 0], &parse_instruction/2)
    |> Enum.product()
  end

  @impl Day
  def b(instructions) do
    instructions
    |> Enum.reduce([0, 0, 0], &parse_instruction/2)
    |> tl() 
    |> Enum.product()
  end

  @impl Day
  def parse_input() do
    with {:ok, file} <- Day.load(__MODULE__) do
      file
      |> String.split(~r/\s/, trim: true)
      |> Enum.chunk(2)
      |> Enum.map(fn [command, value] -> {command, String.to_integer(value)} end)
    end
  end

  defp parse_instruction({"forward", value}, [x, z]) do
    [x + value, z]
  end

  defp parse_instruction({"up", value}, [x, z]) do
    [x, z - value]
  end

  defp parse_instruction({"down", value}, [x, z]) do
    [x, z + value]
  end

  defp parse_instruction({"forward", value}, [aim, x, z]) do
    [aim, x + value, z + value * aim]
  end

  defp parse_instruction({"up", value}, [aim, x, z]) do
    [aim - value, x, z]
  end

  defp parse_instruction({"down", value}, [aim, x, z]) do
    [aim + value, x, z]
  end
end
