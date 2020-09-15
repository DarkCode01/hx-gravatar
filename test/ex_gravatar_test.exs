defmodule ExGravatarTest do
  use ExUnit.Case

  doctest ExGravatar

  test "generate hash" do
    hash = ExGravatar.generate_hash("example@example.com")
    
    assert [49, 197, 84, 60, 23, 52, 210, 92, 114, 6, 245, 253, 89, 21, 37, 208, 41, 91,
    236, 111, 232, 79, 248, 47, 148, 106, 52, 254, 151, 10, 30, 102] == hash
  end

  test "creation of grid or table" do
    hash = ExGravatar.generate_hash("example@example.com")
    grid = ExGravatar.generate_grid(hash)

    assert length(grid) == 54
    assert is_list(grid) == true
  end

  test "creation of row" do
    row = ExGravatar.create_row([1, 2, 3, 4, 5])

    assert is_list(row) == true
    assert row == [1, 2, 3, 4, 5, 4, 3, 2, 1]
  end

  test "print element" do
    element_color = ExGravatar.print_element(true)
    element_without_color = ExGravatar.print_element(false)

    assert is_list(element_color)
    assert is_list(element_without_color)
    assert element_without_color == [[[[] | "\e[37m"], "█"] | "\e[0m"]
    assert element_color == [[[[] | "\e[31m"], "█"] | "\e[0m"]
  end
end
