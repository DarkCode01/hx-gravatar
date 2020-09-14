defmodule ExGravatar do
  @moduledoc """
  Documentation for `ExGravatar`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ExGravatar.hello()
      :world

  """

  alias IO.ANSI, as: Ansi

  @colors [:red, :yellow, :blue, :black]

  def generate(input) do
    color = picker_color()

    input
    |> generate_hash
    |> generate_grid
    |> Enum.map(& rem(&1, 2) == 1)
    |> Enum.map(& print_element(&1, color))
    |> Enum.chunk_every(9, 9, :discard)
    |> Enum.each(& IO.puts(&1))
  end

  def generate_hash(info) do
    :crypto.hash(:sha256, info)
    |> :binary.bin_to_list
  end

  def generate_grid(list) do
    list
    |> Enum.chunk_every(5, 5, :discard)
    |> Enum.map(&create_row/1)
    |> List.flatten
  end

  def create_row(list) do
    list
    |> Enum.chunk_every(4, 4, :discard)
    |> List.flatten
    |> Enum.concat(Enum.reverse(list))
  end

  def print_element(false, _color), do: "█"
  def print_element(true, color), do: Ansi.format([color, "█"])

  def picker_color do
    Enum.random(@colors)
  end
end