defmodule Kare do
  @moduledoc """
    Enables function currying in Elixir.

    iex> curried = Kare.curry(fn x, y, z -> x + y * z end)
    iex> curried.(1).(2).(3)
    7
  """

  def curry(fun) do
    {_, arity} = :erlang.fun_info(fun, :arity)
    curry(fun, arity, [])
  end

  def curry(fun, 0, arguments) do
    apply(fun, Enum.reverse arguments)
  end

  def curry(fun, arity, arguments) do
    fn arg -> curry(fun, arity - 1, [arg | arguments]) end
  end
end
