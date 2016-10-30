defmodule Cocodrilo.ChatView do
  use Cocodrilo.Web, :view

  def render("challenge.json", %{challenge: challenge}), do: challenge |> String.to_integer
end
