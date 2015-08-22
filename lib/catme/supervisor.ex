defmodule Catme.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  @catme_name Catme.Slackbot

  def init(:ok) do
    children = [
      worker(Catme.Slackbot, [[name: @catme_name]])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
