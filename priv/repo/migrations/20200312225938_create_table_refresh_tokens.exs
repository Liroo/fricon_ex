defmodule Fricon.Repo.Migrations.CreateTableRefreshTokens do
  use Ecto.Migration

  def change do
    create table("refresh_tokens") do
      add :token, :text, null: false
      add :expires_at, :utc_datetime, null: false
      add :revoked, :boolean, default: false
      add :revoked_at, :utc_datetime
      timestamps()
    end

    create unique_index(:refresh_tokens, [:token])
  end
end
