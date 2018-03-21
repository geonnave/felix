defmodule HandlerTest do
  use ExUnit.Case
  doctest ElixServer

  test "parse well-formed requests" do
    request = "GET /value HTTP/1.1"
    assert %{method: "GET", path: "/value"} = Handler.parse(request)

    request = "GET /value HTTP/1.1\r\nAccpet: application/json\r\n\r\n"
    assert %{method: "GET", path: "/value"} = Handler.parse(request)
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
end

