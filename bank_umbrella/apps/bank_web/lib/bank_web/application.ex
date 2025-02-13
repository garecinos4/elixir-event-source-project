defmodule BankWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BankWebWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:bank_web, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: BankWeb.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: BankWeb.Finch},
      # Start a worker by calling: BankWeb.Worker.start_link(arg)
      # {BankWeb.Worker, arg},
      # Start to serve requests, typically the last entry
      BankWebWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BankWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BankWebWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
