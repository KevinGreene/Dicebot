defmodule DiceRoller do
  import Enum
    
  def dice_regex do
    {_, r} =  Regex.compile "([0-9]+)(d[0-9]+)?([ks][0-9]+)?"
    r
  end

  def roll_dice(dice_string) do
    String.split(dice_string, "+")
    |> map(fn(x) -> String.strip(x) end)
    |> map(fn(x) -> roll_dice_term(x) end)
    |> sum
  end

  def roll_dice_term(dice_term) do
    case Regex.run(dice_regex, dice_term) do
      [_, n_s] ->
        String.to_integer(n_s)
      
      [_, n_s, "d" <> d_i] ->
        n = String.to_integer(n_s)
        d = String.to_integer(d_i)

        dice_array = build_dice_array n, d        
        sum dice_array

      [_, n_s, "d" <> d_i, "k" <> k_i] ->
        n = String.to_integer(n_s)
        d = String.to_integer(d_i)
        k = String.to_integer(k_i)

        dice_array  = build_dice_array(n, d)
        |> sort
        |> reverse
        |> take k

        sum dice_array

      [_, n_s, "d" <> d_i, "s" <> s_i] ->
        n = String.to_integer(n_s)
        d = String.to_integer(d_i)
        s = String.to_integer(s_i)

        dice_array  = build_dice_array(n, d)
        |> count fn(x) -> x >= s end

    end
  end

  def build_dice_array(number, dice) do
    for n <- 1..number, do: :random.uniform dice
  end
end
