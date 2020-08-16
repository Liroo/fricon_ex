defmodule Fricon.Repo.Migrations.CreateAuthRelation do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :refresh_tokens_id, references(:refresh_tokens, on_delete: :delete_all)
    end
    alter table("refresh_tokens") do
      add :user_id, references(:users, on_delete: :nothing), null: false
    end

    create index(:refresh_tokens, [:user_id])
  end
end
