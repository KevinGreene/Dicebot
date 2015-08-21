defmodule Dice do
  use Application

  def start(_type, _args) do
    Dice.Supervisor.start_link
  end
end
