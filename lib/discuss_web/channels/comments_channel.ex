defmodule DiscussWeb.CommentsChannel do
  use Phoenix.Channel

  import Ecto

  alias Discuss.{Topic, Comment, Repo}

  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)
    topic = Topic
            |> Repo.get(topic_id)
            |> Repo.preload(comments: [:user])

    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  def handle_in(name, %{"content" => content}, socket) do
    topic = socket.assigns.topic
    user_id = socket.assigns.user_id

    changeset = topic
                |> build_assoc(:comments, user_id: user_id)
                |> Comment.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        broadcast!(socket, "comments:#{topic.id}:new", %{comment: comment |> Repo.preload(:user)})
        {:reply, :ok, socket}

      {:error, changeset} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end
end
