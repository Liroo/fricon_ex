defmodule Fricon.Repo.Migrations.CreateTableUsers do
  use Ecto.Migration

  def change do
    create table("users") do
      add :username, :string, null: false
      add :email, :string, null: false
      add :password_hash, :string, null: false
      timestamps()
    end

    create unique_index(:users, [:username])
  end
end
