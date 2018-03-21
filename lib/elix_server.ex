defmodule ElixServer do
  require Logger

  @tcp_options [:binary, active: false, reuseaddr: true]

  def start(port \\ 2222) do
    {:ok, socket} = :gen_tcp.listen(port, @tcp_options)

    Logger.info("Accepting connections on port #{port}")
    loop_acceptor(socket)
  end

  # TODO: make handler configurable, depending on mix env
  # # this change involve understanding configuration (and dependency injection)
  def loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)

    client
    |> receive_request()
    |> Handler.handle()
    |> send_response(client)

    loop_acceptor(socket)
  end

  def receive_request(client) do
    {:ok, request} = :gen_tcp.recv(client, 0)
    Logger.info("Received #{inspect(request)}")
    request
  end

  def send_response(response, client) do
    Logger.info("Sending back #{inspect(response)}")
    :gen_tcp.send(client, response)
    :gen_tcp.close(client)
  end

end

