defmodule Catme.Slackbot do

  use Slack

  def start_link(opts \\ []) do
    start_link(Application.get_env(:tinc, :slack_token), [])
  end

  def init(initial_state, slack) do
    IO.puts "Connected as #{slack.me.name}"
    {:ok, initial_state}
  end

  def handle_message(message = %{type: "message"}, slack, state) do
    case message[:text] do
      "catme" <> cat_string ->
        IO.puts "Getting a cat"
        cat_link = Catme.PugFinder.get_cat
        IO.puts "Got a cat!"
        message_to_send = "Cats!: " <> cat_link
        send_message(message_to_send, message.channel, slack)
      _ ->
    end

    {:ok, state ++ [message[:text]]}
  end

  def handle_message(_message, _slack, state) do
    {:ok, state}
  end
end
