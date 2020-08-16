defmodule Fricon.Schema.User do
  @moduledoc """
  User schema

  This is the user schema. It contains various field representating
  a single user in the app.

  ## Fields

  Here's an overview of the fields.

  | field              | description                                                     | validation             |
  |--------------------|-----------------------------------------------------------------|------------------------|
  | username           | The username, it is used to authenticate the user.              | >3 char, [a-z,0-9,-,_] |
  | email              | The email used for mail and everything. (Not used for auth)     | must be an email       |
  | password           | The password is virtual, this field is only used for validation | >6 char                |
  | password_hash      | The password really stored is an encrypted password.            | none                   |
  | refresh_token      | Refresh token that the user have been generated                 | none                   |

  ## Changeset

  Here's available changeset and their utility

  - `create_changeset`: Used when you create an user.
  - `changeset`: Used when you update misc information from user such as `email`.
  - `update_password_changeset`: Used when you update the password.

  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Fricon.Schema.RefreshToken

  @username_regex ~r/^[[:alnum:]\-\_]+$/
  @email_regex ~r/^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-\.]+\.[a-zA-Z]{2,}$/

  @type t :: %__MODULE__{
          username: String.t(),
          email: String.t(),
          password_hash: String.t(),
          refresh_tokens: [RefreshToken.t] | %Ecto.Association.NotLoaded{},
          inserted_at: DateTime.t(),
          updated_at: DateTime.t(),
          id: integer
        }

  schema "users" do
    field :username, :string
    field :email, :string

    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :refresh_tokens, RefreshToken, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email])
    |> validate_required([:email])
  end

  @doc false
  def create_changeset(%__MODULE__{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :username, :password])
    |> validate_required([:email, :username, :password])
    |> validate_username()
    |> validate_email()
    |> validate_password()
    |> put_pass_hash()
  end

  def update_password_changeset(%__MODULE__{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:password])
    |> validate_required([:password])
    |> validate_password()
    |> put_pass_hash()
  end

  defp validate_email(changeset) do
    changeset
    |> validate_format(:email, @email_regex)
    |> validate_length(:email, max: 255)
  end

  defp validate_password(changeset) do
    changeset
    |> validate_length(:password, min: 6, max: 255)
    |> validate_format(:password, @username_regex)
  end

  defp validate_username(changeset) do
    changeset
    |> validate_length(:username, min: 3, max: 255)
    |> unique_constraint(:username)
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
