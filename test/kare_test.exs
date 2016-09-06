defmodule KareTest do
  use ExUnit.Case

  test "curry function with multiple arguments" do
    curried = Kare.curry(fn x, y, z -> x + y * z end)
    assert(curried.(1).(2).(3) == 7)
  end

  test "curry functions in pipe chain" do
    replace = (fn what ->
      Kare.curry(fn replacement, word ->
        Regex.replace(what, word, replacement)
      end)
    end)

    disallow = replace.(~r/[abc]/)
    censor = disallow.("*")
    raw = "AbCdaBcD"

    censored =
      raw
      |> String.downcase
      |> censor.()

    assert(censored === "***d***d")
  end
end
