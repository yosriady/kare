# Kare

Function currying in Elixir.

## Installation

  Add kare to your list of dependencies in `mix.exs`:

        def deps do
          [{:kare, "~> 1.0.0"}]
        end


## Usage

> curried function with multiple arguments

```
iex> curried = Kare.curry(fn x, y, z -> x + y * z end)
iex> curried.(1).(2).(3)
7
```


> curried functions in pipe chain

```
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
```
