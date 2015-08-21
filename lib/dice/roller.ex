defmodule Dice.Roller do
  import Enum
    
  def dice_regex do
    {_, r} =  Regex.compile "([0-9]+)(d[0-9]+)?([ks][0-9]+)?"
    r
  end

  def roll_dice(dice_string) do
    IO.puts "Rolling the die"
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

        {:ok, dice_array}  = build_dice_array(n, d)
        IO.puts dice_array
        sum dice_array

      [_, n_s, "d" <> d_i, "k" <> k_i] ->
        n = String.to_integer(n_s)
        d = String.to_integer(d_i)
        k = String.to_integer(k_i)

        {:ok, dice_array}  = build_dice_array(n, d)
                
        dice_array
        |> sort
        |> reverse
        |> take k
        |> sum

      [_, n_s, "d" <> d_i, "s" <> s_i] ->
        n = String.to_integer(n_s)
        d = String.to_integer(d_i)
        s = String.to_integer(s_i)

        {:ok, dice_array} = build_dice_array(n, d)
        IO.puts dice_array
      
        dice_array |> count fn(x) -> x >= s end

    end
  end

  def build_dice_array(number, dice) do
    cond do
      number > 500 -> {:error, "Don't roll that many dice"}
      dice > 500 -> {:error, "Don't roll dice that high"}
      true -> {:ok, (for _ <- 1..number, do: :random.uniform dice)}
    end
  end
end
