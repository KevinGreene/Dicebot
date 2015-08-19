defmodule DiceSlackbot do

  use Slack
  require DiceRoller

  def start(status, args) do
    start_link(Application.get_env(:dicebot, :slack_token), [])
  end
  
  def init(initial_state, slack) do
    IO.puts "Connected as #{slack.me.name}"
    {:ok, initial_state}
  end

  def handle_message(message = %{type: "message"}, slack, state) do
    case message[:text] do
      "dicebot" <> dice_string ->
        result = DiceRoller.roll_dice(dice_string)
        username = slack.users[message.user].name
        message_to_send = "#{username} rolled a #{result}"
        send_message(message_to_send, message.channel, slack)
      _ ->
    end

    {:ok, state ++ [message[:text]]}
  end

  def handle_message(_message, _slack, state) do
    {:ok, state}
  end
end
