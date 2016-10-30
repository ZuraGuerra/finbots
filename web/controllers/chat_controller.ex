defmodule Cocodrilo.ChatController do
  use Cocodrilo.Web, :controller

  def chat(conn, %{"hub.challenge" => challenge}),
    do: render conn, "challenge.json", challenge: challenge
end
