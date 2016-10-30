defmodule Cocodrilo.ChatView do
  use Cocodrilo.Web, :view

  def render("challenge.json", %{challenge: challenge}), do: challenge |> String.to_integer

  def render("test.json", %{text: text}), do: %{}

  def render("callback_response.json", %{}), do: %{}
end
