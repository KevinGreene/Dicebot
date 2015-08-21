defmodule Dice.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  @dicebot_name Dice.Slackbot
  

  def init(:ok) do
    children = [
      worker(Dice.Slackbot, [[name: @dicebot_name]])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
