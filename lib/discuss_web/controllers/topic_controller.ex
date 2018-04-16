defmodule DiscussWeb.TopicController do
  alias Discuss.Topic

  use DiscussWeb, :controller

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic} = params) do

  end
end
