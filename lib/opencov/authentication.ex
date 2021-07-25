defmodule Opencov.Authentication do
  import Plug.Conn, only: [put_session: 3, delete_session: 2]

  @user_id_key :user_id

  def login(conn, user) do
    put_session(conn, user_id_key(), user.id)
  end

  def logout(conn) do
    delete_session(conn, user_id_key())
  end

  def user_id_key() do
    @user_id_key
  end
end
