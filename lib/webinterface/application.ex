defmodule Webinterface.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Webinterface.Supervisor]
    Supervisor.start_link(get_children(), opts)
  end
  defp get_children() do
    [
      # Start the Telemetry supervisor
      WebinterfaceWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Webinterface.PubSub},
      # Start the Endpoint (http/https)
      WebinterfaceWeb.Endpoint,
    ]
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WebinterfaceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
