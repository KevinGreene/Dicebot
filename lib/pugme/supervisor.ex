defmodule Pugme.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  @pugme_name Pugme.Slackbot

  def init(:ok) do
    children = [
      worker(Pugme.Slackbot, [[name: @pugme_name]])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
