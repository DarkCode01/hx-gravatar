defmodule ExGravatar do
  @moduledoc """
  Module to generate a simple gravatar iimage [ACSII]
  """

  alias IO.ANSI, as: Ansi

  @doc """
  Display the gravatar acsii image

  ## Examples

      iex> ExGravatar.generate("example@example.com")
      [
        [
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"]
        ],
        [
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"]
        ],
        [
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"]
        ],
        [
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"]
        ],
        [
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"]
        ],
        [
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[31m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"],
          [[[[] | "\e[37m"], "█"] | "\e[0m"]
        ]
      ]

  """
  @spec generate(String.t()) :: Enumerable.t()
  def generate(input) do
    input
    |> generate_hash
    |> generate_grid
    |> Enum.map(& rem(&1, 2) == 1)
    |> Enum.map(&print_element/1)
    |> Enum.chunk_every(9, 9, :discard)
  end

  @doc """
  Generate sha256 hash to create grid.

  ## Examples
      iex> ExGravatar.generate_hash("example@example.com")
      [49, 197, 84, 60, 23, 52, 210, 92, 114, 6, 245, 253, 89, 21, 37, 208, 41, 91, 236, 111, 232, 79, 248, 47, 148, 106, 52, 254, 151, 10, 30, 102]
  """
  @spec generate(String.t()) :: Enumerable.t()
  def generate_hash(info) do
    :crypto.hash(:sha256, info)
    |> :binary.bin_to_list
  end

  @doc """
  Generate grid/table of image gravatar.
  """
  @spec generate(Enumerable.t()) :: Enumerable.t()
  def generate_grid(list) do
    list
    |> Enum.chunk_every(5, 5, :discard)
    |> Enum.map(&create_row/1)
    |> List.flatten
  end

  @doc """
  Implemente mirror to elements of a row

  ## Examples
      iex> ExGravatar.create_row([1, 2, 3, 4, 5])
      [1, 2, 3, 4, 5, 4, 3, 2, 1]
  """
  @spec generate(Enumerable.t()) :: Enumerable.t()
  def create_row(list) do
    list
    |> Enum.chunk_every(4, 4, :discard)
    |> List.flatten
    |> Enum.concat(Enum.reverse(list))
  end

  @doc """
  Impure function to display gravatar.
  """
  @spec generate(Enumerable.t()) :: Atom.t()
  def print_gravatar(gravatar) do
    gravatar
    |> Enum.each(&IO.puts/1)
  end

  @doc """
  Replace all odd and not-odd cell by colors.

  ## Examples
      iex> ExGravatar.print_element(true)
      [[[[] | "\e[31m"], "█"] | "\e[0m"]
      iex> ExGravatar.print_element(false)
      [[[[] | "\e[37m"], "█"] | "\e[0m"]
  """
  @spec generate(Atom.t()) :: Enumerable.t()
  def print_element(false), do: Ansi.format([:white, "█"])
  def print_element(true), do: Ansi.format([:red, "█"])
end