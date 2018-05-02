defmodule Discuss.Repo.Migrations.AddUsers do
  use Ecto.Migration

  alias Discuss.User

  def change do
    create table(:users) do
      add :email, :string
      add :provider, :string
      add :token, :string

      belongs_to(:user, User)

      timestamps()
    end
  end
end
