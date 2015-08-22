defmodule Tinc do
  use Application

  def start(_type, _args) do
    Dice.Supervisor.start_link
    Pugme.Supervisor.start_link
    Catme.Supervisor.start_link
  end
end
