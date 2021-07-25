defmodule Opencov.Authentication do
  alias Opencov.User
  alias Opencov.UserManager
  alias Opencov.UserService
  alias Opencov.Repo

  import Plug.Conn, only: [put_session: 3, delete_session: 2]

  @user_id_key :user_id

  def login(conn, email, name) do
    userToLogin = Repo.get_by(User, email: email)
    if is_nil(userToLogin) do
      changeset = UserManager.changeset(%User{}, %{email: email, name: name, admin: true})
      case Repo.insert(changeset) do
        {:ok, user} = res ->
          userToLogin = user
          res
        err -> 
          err
      end
      UserService.finalize_confirmation!(userToLogin)
    end
    put_session(conn, user_id_key(), userToLogin.id)
  end

  def logout(conn) do
    delete_session(conn, user_id_key())
  end

  def user_id_key() do
    @user_id_key
  end
end
