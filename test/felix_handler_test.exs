defmodule FelixHandlerTest do
  use ExUnit.Case
  doctest Felix

  alias Felix.Handler

  defmodule TestApp.Endpoint do
    use Felix.Endpoint
    def pipeline do
      [TestApp.Router]
    end
  end
  defmodule TestApp.Router do
    use Felix.Router
    def match("GET", ["value"], connection) do
      connection
      |> put_in([:resp_body], "hola que tal")
      |> put_in([:status], "200 Ok")
    end
    def match(method, path, connection) do
      connection
      |> put_in([:resp_body], "#{method} #{path} not found")
      |> put_in([:status], "404 Not Found")
    end
  end

  test "handle request" do
    Application.put_env(:felix, :app_endpoint, TestApp.Endpoint)

    request = "GET /value HTTP/1.1\r\n\r\n"
    assert "HTTP/1.1 200 Ok" <> _rest = Handler.handle(request)

    request = "GET /fasfasfas HTTP/1.1\r\n\r\n"
    assert "HTTP/1.1 404 Not Found" <> _rest = Handler.handle(request)
  end

end

