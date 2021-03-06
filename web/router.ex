defmodule Cocodrilo.Router do
  use Cocodrilo.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Cocodrilo do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", Cocodrilo do
    pipe_through :api

    get "/chat", ChatController, :chat
    post "/chat", ChatController, :chat
  end
end
