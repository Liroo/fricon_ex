# Fricon

## IMPORTANT TO READ

The project is actually in development. A lot of part (could be every) are unimplemented. The doc may be non existant. The project could not be stable.

This message will stay until the 1.0.0 version.

## Project

Fricon is a project about trading. 💸 Its ambition is to provide an easy way to automatize the trading with little knowledge of the stock market.

It's an open-source self hosted solution that you can use with the front that will comes together (not yet developped).

The API will be split in parts such as:
  - API: a REST API that render json. Used for any comunication with external client.
  - Providers: Brokers or data providers are used to directly interact with stock exchanges or to provide data such as stock price.
  - Bot: The bot is configurable from the interface or using file. It could be configurable for each index or used for many.
  - The database: It is logically used to keep every data possible in one place.

## Requirement

The project is build with [Elixir][elixir] which is itself built on top of [erlang][erlang]. The database used is [PostgreSQL][postgresql]. The coolest way to install [elixir][elixir] is [asdf][asdf].

  - Elixir: > 1.10
  - Erlang: > 22
  - PostgreSQL: > 12

## Installation

  - Install dependencies with `mix deps.get`
  - Create and migrate your database with `mix ecto.setup`
  - Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Appendix

The repository is currently open-sourced. It's not necessary for an infinite time but I don't find a reason why I would put this one in private.

[elixir]: https://elixir-lang.org/
[erlang]: https://www.erlang.org/
[phoenix]: https://www.phoenixframework.org/
[postgresql]: https://www.postgresql.org/
[asdf]: https://github.com/asdf-vm/asdf