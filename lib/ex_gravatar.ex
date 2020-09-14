defmodule ExGravatar do
  @moduledoc """
  Module to generate a simple gravatar iimage [ACSII]
  """

  alias IO.ANSI, as: Ansi

  @colors [:red, :yellow, :blue, :black]

  @doc """
  Display the gravatar acsii image

  ## Examples

      iex> ExGravatar.generate("example@example.com")
      █████████
      █████████
      █████████
      █████████
      █████████
      █████████
      :ok

  """
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

  @doc false
  def generate_hash(info) do
    :crypto.hash(:sha256, info)
    |> :binary.bin_to_list
  end

  @doc false
  def generate_grid(list) do
    list
    |> Enum.chunk_every(5, 5, :discard)
    |> Enum.map(&create_row/1)
    |> List.flatten
  end

  @doc false
  def create_row(list) do
    list
    |> Enum.chunk_every(4, 4, :discard)
    |> List.flatten
    |> Enum.concat(Enum.reverse(list))
  end

  @doc false
  def print_element(false, _color), do: "█"
  def print_element(true, color), do: Ansi.format([color, "█"])

  @doc false
  def picker_color do
    Enum.random(@colors)
  end
end