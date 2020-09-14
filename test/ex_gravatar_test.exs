defmodule ExGravatarTest do
  use ExUnit.Case
  doctest ExGravatar

  test "greets the world" do
    assert ExGravatar.hello() == :world
  end
end
