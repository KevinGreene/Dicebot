defmodule Dice.Roller do
  import Enum
    
  def dice_regex do
    {_, r} =  Regex.compile "([0-9]+)(d[0-9]+|f)?([ks][0-9]+)?"
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

      [_, n_s, dice | qualifiers] ->
        n = String.to_integer(n_s)

        {:ok, dice_array} =
          case dice do
            "f" ->
              build_fudge_dice_array(n)
            "d" <> d_i ->
              d = String.to_integer(d_i)
              build_dice_array(n, d)
          end
        IO.puts "Rolled the dice!: "
        IO.inspect dice_array
        
        case qualifiers do 
          ["k" <> k_i] ->
            k = String.to_integer(k_i)

            dice_array
            |> sort
            |> reverse
            |> take(k)
            |> sum

          ["s" <> s_i] ->
            s = String.to_integer(s_i)
            IO.puts "Successes"
          dice_array |> count fn(x) -> x >= s end

          _ -> 
            sum dice_array
        end


    end
  end

  def build_dice_array(number, dice) do
    cond do
      number > 500 -> {:error, "Don't roll that many dice"}
      dice > 500 -> {:error, "Don't roll dice that high"}
      true -> {:ok, (for _ <- 1..number, do: :random.uniform dice)}
    end
  end

  def build_fudge_dice_array(number) do
    cond do
      number > 500 -> {:error, "Don't roll that many dice"}
      true -> {:ok, (for _ <- 1..number, do: :random.uniform(3) - 2)}
    end
  end
end

