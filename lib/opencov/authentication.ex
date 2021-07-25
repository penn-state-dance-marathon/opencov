defmodule Opencov.Authentication do
  alias Opencov.User
  alias Opencov.UserManager
  alias Opencov.Repo

  import Plug.Conn, only: [put_session: 3, delete_session: 2]

  @user_id_key :user_id

  def login(conn, email, name) do
    userToLogin = Repo.get_by(User, email: email)
    IO.puts "hi"
    if is_nil(userToLogin) do
      IO.puts "is nil"
      changeset = UserManager.changeset(%User{}, %{email: email, name: name, admin: true})
      IO.puts "changeset"
      case Repo.insert(changeset) do
        {:ok, user} = res ->
          IO.puts "hi2"
          userToLogin = user
          IO.inspect userToLogin
          IO.puts "hi3"
          res
        err -> 
          IO.inspect err
          err
      end
    end
    IO.puts "hi4"
    IO.inspect userToLogin
    put_session(conn, user_id_key(), userToLogin.id)
  end

  def logout(conn) do
    delete_session(conn, user_id_key())
  end

  def user_id_key() do
    @user_id_key
  end
end
