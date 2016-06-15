defmodule EchoServer do
  require Logger

  def listen(port) do
    :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])
    Logger.info "Listen connection on port #{port}"
  end
end
