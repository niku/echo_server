defmodule EchoServer do
  def start(port) do
    import Supervisor.Spec
    children = [
      worker(EchoServer.Worker, [port])
    ]
    opts = [strategy: :one_for_one, name: EchoServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
