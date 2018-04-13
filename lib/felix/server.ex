defmodule Felix.Server do
  use Task
  require Logger

  @tcp_options [:binary, active: false, reuseaddr: true]

  def start_link(port) do
    Task.start_link(__MODULE__, :run, [port])
  end

  def run(port) do
    {:ok, socket} = :gen_tcp.listen(port, @tcp_options)
    Logger.info("Accepting connections on port #{port}")

    loop_acceptor(socket)
  end

  def loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)

    {:ok, pid} = Task.Supervisor.start_child(Felix.Handler.TaskSupervisor, fn ->
      # Process.sleep(3000)
      client
      |> receive_request()
      |> Felix.Handler.handle()
      |> send_response(client)
    end)
    :gen_tcp.controlling_process(client, pid)

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
