defmodule Discuss.Topic do
  use Ecto.Schema

  import Ecto.Changeset

  alias Discuss.User

  schema "topics" do
    field(:title, :string)

    belongs_to(:user, User)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
