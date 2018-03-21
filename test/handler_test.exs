defmodule HandlerTest do
  use ExUnit.Case
  doctest ElixServer

  test "parse well-formed requests" do
    request = "GET /value HTTP/1.1"
    assert %{method: "GET", path: ["value"]} = Handler.parse(request)

    request = "GET /value HTTP/1.1\r\nAccpet: application/json\r\n\r\n"
    assert %{method: "GET", path: ["value"]} = Handler.parse(request)

    request = "GET //value HTTP/1.1"
    assert %{method: "GET", path: ["value"]} = Handler.parse(request)

    request = "GET /items/1 HTTP/1.1"
    assert %{method: "GET", path: ["items", "1"]} = Handler.parse(request)
  end

  test "raise on badly-formed requests" do
    request = "GET /value"
    assert_raise CaseClauseError, fn ->
      Handler.parse(request)
    end

    request = "GREET /value HTTP/1.1"
    assert_raise CaseClauseError, fn ->
      Handler.parse(request)
    end
  end

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
    request = "GET /value HTTP/1.1"
    assert "HTTP/1.1 200 Ok" <> _rest = Handler.handle(request)

    request = "GET /fasfasfas HTTP/1.1"
    assert "HTTP/1.1 404 Not Found" <> _rest = Handler.handle(request)
  end

end

