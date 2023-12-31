defmodule Media.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      MediaWeb.Telemetry,
      # Start the Ecto repository
      Media.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Media.PubSub},
      # Start Finch
      {Finch, name: Media.Finch},
      # Start the Endpoint (http/https)
      MediaWeb.Endpoint
      # Start a worker by calling: Media.Worker.start_link(arg)
      # {Media.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Media.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MediaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
