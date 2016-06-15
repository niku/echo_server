defmodule EchoServer do
  require Logger

  def listen(port) do
    {:ok, listen_socket} = :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])
    Logger.info "Listen connection on port #{port}"
    accept(listen_socket)
  end

  defp accept(listen_socket) do
    :gen_tcp.accept(listen_socket)
    Logger.info "A connection accepted"
  end
end
