defmodule HandlerTest do
  use ExUnit.Case
  doctest ElixServer

  test "build http response" do
    response = """
    HTTP/1.1 200 Ok\r
    Content-type: text/plain\r
    \r
    hola que tal
    """

    context = %{status: "200 Ok", resp_body: "hola que tal"}
    assert ^response = Handler.build_resp(context)
  end

  test "handle request" do
    request = "GET /value HTTP/1.1\r\n\r\n"
    assert "HTTP/1.1 200 Ok" <> _rest = Handler.handle(request)

    request = "GET /fasfasfas HTTP/1.1\r\n\r\n"
    assert "HTTP/1.1 404 Not Found" <> _rest = Handler.handle(request)
  end

end

