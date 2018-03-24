defmodule Felix.Server do
  require Logger

  @tcp_options [:binary, active: false, reuseaddr: true]

  # TODO: make this part of a supervision tree
  def start(port \\ 2222) do
    {:ok, socket} = :gen_tcp.listen(port, @tcp_options)

    Logger.info("Accepting connections on port #{port}")
    loop_acceptor(socket)
  end

  def loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)

    # TODO: make it part of a supervision tree
    spawn(fn ->
      client
      |> receive_request()
      |> Felix.Handler.handle()
      |> send_response(client)
    end)

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

