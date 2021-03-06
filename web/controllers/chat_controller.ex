defmodule Cocodrilo.ChatController do
  use Cocodrilo.Web, :controller

  @messages_url "https://graph.facebook.com/v2.6/me/messages?access_token="
  @page_token System.get_env("PAGE_TOKEN")
  @tropo_url "https://api.tropo.com/1.0/sessions?action=create&token="
  @tropo_creds System.get_env("TROPO_CREDS")
  @first_card 2845
  @second_card 500

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
                "title" => "Buscar sucursales",
                "payload" => "Sucursales cerca de mí"
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

  def chat(conn, %{"entry" => [%{"messaging" => [%{"postback" => %{"payload" => "Sucursales cerca de mí"},
                                                   "recipient" => %{"id" => page_id},
                                                   "sender" => %{"id" => user_id}}|_]}|_]}) do
     message = %{
       "recipient" => %{"id" => user_id},
       "message" => %{
         "attachment" => %{
           "type" => "template",
           "payload" => %{
             "template_type" => "button",
             "text" => "¿En dónde te encuentras?",
             "buttons" => [
               %{
                 "type" => "postback",
                 "title" => "Cancún",
                 "payload" => "Cancún"
               },
               %{
                 "type" => "postback",
                 "title" => "Playa del Carmen",
                 "payload" => "Playa del Carmen"
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

  def chat(conn, %{"entry" => [%{"messaging" => [%{"postback" => %{"payload" => "Cancún"},
                                                   "recipient" => %{"id" => page_id},
                                                   "sender" => %{"id" => user_id}}|_]}|_]}) do
     message = %{
       "recipient" => %{"id" => user_id},
       "message" => %{
         "attachment" => %{
           "type" => "template",
           "payload" => %{
             "template_type" => "button",
             "text" => "Consulta tus sucursales más cercanas",
             "buttons" => [
               %{
                 "type" => "web_url",
                 "url" => "https://www.google.com.mx/maps/search/bancomer+cancun/@21.0467368,-86.8733953,13z/data=!3m1!4b1?hl=en",
                 "title" => "Ver mapa"
               }
             ]
           }
         }
       }
     }
     message = message |> JSX.encode!
     url = @messages_url <> @page_token
     System.cmd("curl", ["-X", "POST", "-H", "Content-Type: application/json", "-d", message, url])
     render conn, "test.json", text: "wololo"
  end

  def chat(conn, %{"entry" => [%{"messaging" => [%{"postback" => %{"payload" => "Playa del Carmen"},
                                                   "recipient" => %{"id" => page_id},
                                                   "sender" => %{"id" => user_id}}|_]}|_]}) do
     message = %{
       "recipient" => %{"id" => user_id},
       "message" => %{
         "attachment" => %{
           "type" => "template",
           "payload" => %{
             "template_type" => "button",
             "text" => "Consulta tus sucursales más cercanas",
             "buttons" => [
               %{
                 "type" => "web_url",
                 "url" => "https://www.google.com.mx/maps/search/bancomer+playa+del+carmen/@20.640232,-87.1000117,14z/data=!3m1!4b1?hl=en",
                 "title" => "Ver mapa"
               }
             ]
           }
         }
       }
     }
     message = message |> JSX.encode!
     url = @messages_url <> @page_token
     System.cmd("curl", ["-X", "POST", "-H", "Content-Type: application/json", "-d", message, url])
     render conn, "test.json", text: "wololo"
  end

  def chat(conn, %{"entry" => [%{"messaging" => [%{"postback" => %{"payload" => "Me gustaría conocer mi saldo"},
                                                   "recipient" => %{"id" => page_id},
                                                   "sender" => %{"id" => user_id}}|_]}|_]}) do
    message = %{
     "recipient" => %{"id" => user_id},
     "message" => %{
       "attachment" => %{
         "type" => "template",
         "payload" => %{
           "template_type" => "receipt",
           "recipient_name" => "Jennifer López",
           "order_number" => random_num,
           "currency" => "MXN",
           "payment_method" => "Visa 3471",
           "elements" => [
             %{
               "title" => "Vida Oro 2843",
               "price" => @first_card,
               "image_url" => "http://i.imgur.com/SQM4eLo.jpg"
             },
             %{
               "title" => "Afinidad UNAM 6745",
               "price" => @second_card,
               "image_url" => "http://i.imgur.com/or00xEe.jpg"
             }
           ],
           "summary" => %{
             "total_cost" => @first_card + @second_card
           }
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
       "message" => %{
         "attachment" => %{
           "type" => "template",
           "payload" => %{
             "template_type" => "button",
             "text" => "Siento mucho que tengas problemas con tu tarjeta. Presiona el botón para que un asesor pueda apoyarte con esta situación.",
             "buttons" => [
               %{
                 "type" => "web_url",
                 "url" => @tropo_url <> @tropo_creds,
                 "title" => "Llamar asesor"
               }
             ]
           }
         }
       }
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

  defp random_num, do: :random.uniform * 10000000 |> round
end
