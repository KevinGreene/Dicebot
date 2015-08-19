DiceSlackbot
============

This Elixir project is designed to run a comprehensive Slack Bot Integration for dice rolling.


Setup
-----

First, create a bot integration via Slack. You can create one from

https://#{your_slack_group}.slack.com/services/new/bot

Grab the API token given when you created the bot

Then, simply run the app with

```
DICEBOT_API_TOKEN="#{your_new_api_token}" mix run --no-halt
```

Basic Usage
-----------

```
kevin [7:45 PM] 
dicebot 1d6

dicebot [7:45 PM] 
kevin rolled a 5
```

Current Features
----------------

* Multiple terms - `dicebot 1d6+3`
* Keep - `dicebot 4d6k3`

Planned Features
----------------

* Subtraction - `dicebot 1d6-2`
* Exploding dice - `dicebot 4d6e6`
* Success dice - `dicebot 10d10s7`
* Fudge dice - `dicebot 4df`
