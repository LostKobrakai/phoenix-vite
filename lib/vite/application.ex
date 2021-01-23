defmodule Vite.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ViteWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Vite.PubSub},
      # Start the Endpoint (http/https)
      ViteWeb.Endpoint
      # Start a worker by calling: Vite.Worker.start_link(arg)
      # {Vite.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Vite.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ViteWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
