Tinc
====

Elixir project is designed to run a comprehensive Slack Bot Integration for dice rolling.


Setup
-----

First, create a bot integration via Slack. You can create one from

https://#{your_slack_group}.slack.com/services/new/bot

Grab the API token given when you created the bot

Add that API token to `config/private.exs` which should look like this:

```
use Mix.Config

config :tinc, :slack_token, "YOUR ACTUAL API TOKEN HERE"
```

```
mix run --no-halt
```

Basic Dicebot Usage
-------------------

```
kevin [7:45 PM] 
dicebot 1d6

dicebot [7:45 PM] 
kevin rolled a 5
```

Current Dicebot Features
------------------------

* Multiple terms - `dicebot 1d6+3`
* Keep - `dicebot 4d6k3`
* Success dice - `dicebot 10d10s7` - Displays the number of dice that rolled at least the number after 's'
* Subtraction - `dicebot 1d6-2`
* Fudge dice - `dicebot 4f`

Planned Dicebot Features
------------------------

* Exploding dice - `dicebot 4d6e6`
