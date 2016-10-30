defmodule Cocodrilo.ChatController do
  use Cocodrilo.Web, :controller

  @messages_url "https://graph.facebook.com/v2.6/me/messages?access_token="
  @page_token System.get_env("PAGE_TOKEN")

  def chat(conn, %{"hub.challenge" => challenge}),
    do: render conn, "challenge.json", challenge: challenge

  def chat(conn, %{"entry" => [%{"messaging" => [%{"postback" => %{"payload" => "Chatea con un asesor"},
                                                   "recipient" => %{"id" => page_id},
                                                   "sender" => %{"id" => user_id}}|_]}|_]}) do

    message = %{
      "recipient" => %{"id" => user_id},
      "message" => %{
        "attachment" => %{
          "type" => "template",
          "payload" => %{
            "template_type" => "button",
            "text" => "Hola, soy tu asistente personal de Doge Bank. ¿Cómo puedo ayudarte?",
            "buttons" => [
              %{
                "type" => "postback",
                "title" => "Reportar mi tarjeta",
                "payload" => "Quiero reportar mi tarjeta"
              },
              %{
                "type" => "postback",
                "title" => "Ver mi saldo",
                "payload" => "Me gustaría conocer mi saldo"
              },
              %{
                "type" => "postback",
                "title" => "Conversión de divisas",
                "payload" => "Quiero saber su precio de cambio para una divisa extranjera"
              }
            ]
          }
        }
      }
    }
    message = message |> JSX.encode!
    url = @messages_url <> @page_token
    System.cmd("curl", ["-X", "POST", "-H", "Content-Type: application/json", "-d", message, url])
    render conn, "test.json", text: "text"
  end

  def chat(conn, %{"entry" => [%{"messaging" => [%{"postback" => %{"payload" => "Quiero reportar mi tarjeta"},
                                                   "recipient" => %{"id" => page_id},
                                                   "sender" => %{"id" => user_id}}|_]}|_]}) do
     message = %{
       "recipient" => %{"id" => user_id},
       "message" => %{"text" => "Siento mucho que tengas problemas con tu tarjeta. Por favor, proporciónanos tu número de celular para que un asesor pueda apoyarte con esta situación."}
     }
     message = message |> JSX.encode!
     url = @messages_url <> @page_token
     System.cmd("curl", ["-X", "POST", "-H", "Content-Type: application/json", "-d", message, url])
     render conn, "test.json", text: "wololo"
  end

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
