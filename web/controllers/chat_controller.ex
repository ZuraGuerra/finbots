defmodule Cocodrilo.ChatController do
  use Cocodrilo.Web, :controller
  require IEx

  def chat(conn, %{"hub.challenge" => challenge}),
    do: render conn, "challenge.json", challenge: challenge

  def chat(conn, %{"entry" => [%{"messaging" => [%{"message" => %{"text" => text}}|_]}|_]}) do
    IO.puts text
    render conn, "test.json", text: text
  end
end
