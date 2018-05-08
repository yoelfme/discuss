defmodule Discuss.Topic do
  use Ecto.Schema

  import Ecto.Changeset

  alias Discuss.{User, Comment}

  schema "topics" do
    field(:title, :string)

    belongs_to(:user, User)
    has_many(:comments, Comment)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
