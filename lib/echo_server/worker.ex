defmodule EchoServer.Worker do
  require Logger

  def start_link(port) do
    listen(port)
  end

  def listen(port) do
    {:ok, listen_socket} = :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])
    Logger.info "Listen connection on port #{port}"
    accept(listen_socket)
  end

  defp accept(listen_socket) do
    {:ok, socket} = :gen_tcp.accept(listen_socket)
    Logger.info "A connection accepted"
    spawn_link(fn ->
      echo(socket)
    end)
    accept(listen_socket)
  end

  defp echo(socket) do
    line = read_line(socket)
    write_line(socket, line)
    echo(socket)
  end

  defp read_line(socket) do
    {:ok, line} = :gen_tcp.recv(socket, 0)
    Logger.debug "#{inspect socket} receives #{line}"
    line
  end

  defp write_line(socket, line) do
    :gen_tcp.send(socket, line)
    Logger.debug "#{inspect socket} sends #{line}"
  end
end
