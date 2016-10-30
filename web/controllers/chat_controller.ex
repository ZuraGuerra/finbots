defmodule Cocodrilo.ChatController do
  use Cocodrilo.Web, :controller

  @messages_url "https://graph.facebook.com/v2.6/me/messages?access_token="
  @page_token System.get_env("PAGE_TOKEN")

  def chat(conn, %{"hub.challenge" => challenge}),
    do: render conn, "challenge.json", challenge: challenge

  def chat(conn, %{"entry" => [%{"messaging" => [%{"message" => %{"text" => text}}|_]}|_]}) do
    message = %{
      "recipient" => %{"id" => 1104490799647266},
      "message" => %{
        "attachment" => %{
          "type" => "template",
          "payload" => %{
            "template_type" => "button",
            "text" => "uwu?",
            "buttons" => [
              %{
                "type" => "web_url",
                "url" => "http://zura.space",
                "title" => "ZURINHA"
              },
              %{
                "type" => "postback",
                "title" => "OvO",
                "payload" => "KHÉ?!"
              }
            ]
          }
        }
      }
    }
    message = message |> JSX.encode!
    url = @messages_url <> @page_token
    System.cmd("curl", ["-X", "POST", "-H", "Content-Type: application/json", "-d", message, url])
    render conn, "test.json", text: text
  end

  def chat(conn, %{"object" => "page"}) do
    render conn, "callback_response.json"
  end
end
