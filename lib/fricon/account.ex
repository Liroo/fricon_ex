defmodule Fricon.Account do
  @moduledoc """
  User context
  """

  import Ecto.Query, warn: false

  alias Fricon.{Schema.User, Repo}

  @type changeset_error :: {:error, Ecto.Changeset.t()}
  @type credentials :: %{username: String.t, password: String.t}

  @doc """
  Check credentials and return the corresponding user
  """
  @spec check_credentials(credentials :: credentials) :: {:ok, User.t} | {:error, String.t}
  def check_credentials(%{"username" => username, "password" => password}) do
    %{"username" => username}
    |> get_by()
    |> Argon2.check_pass(password)
  end

  @doc """
  Returns the list of users.
  """
  @spec list_users() :: [User.t]
  def list_users, do: Repo.all(User)

  @doc """
  Gets a single user.
  """
  @spec get_user!(integer) :: User.t | no_return
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Gets a user based on the params.
  This is used by Phauxth to get user information.
  """
  @spec get_by(map) :: User.t | nil
  def get_by(%{"username" => username}) do
    Repo.get_by(User, username: username)
  end

  @doc """
  Creates a user.
  """
  @spec create_user(map) :: {:ok, User.t} | changeset_error
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.
  """
  @spec update_user(User.t, map) :: {:ok, User.t} | changeset_error
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.
  """
  @spec delete_user(User.t) :: {:ok, User.t} | changeset_error
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.
  """
  @spec change_user(User.t) :: Ecto.Changeset.t()
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @doc """
  Updates a user's password.
  """
  @spec update_password(User.t, map) :: {:ok, User.t} | changeset_error
  def update_password(%User{} = user, attrs) do
    # delete every refresh tokens

    user
    |> User.update_password_changeset(attrs)
    |> Repo.update()
  end
end
