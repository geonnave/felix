defmodule ParserTest do
  use ExUnit.Case
  doctest ElixServer

  test "parse well-formed requests" do
    request = "GET /value HTTP/1.1\r\n\r\n"
    assert %{method: "GET", path: ["value"]} = Parser.parse(request)

    request = "GET /value HTTP/1.1\r\nAccpet: application/json\r\n\r\n"
    assert %{method: "GET", path: ["value"]} = Parser.parse(request)
  end

  test "parse well-formed requests into lists" do
    request = "GET / HTTP/1.1\r\n\r\n"
    assert %{method: "GET", path: []} = Parser.parse(request)

    request = "GET //value HTTP/1.1\r\n\r\n"
    assert %{method: "GET", path: ["value"]} = Parser.parse(request)

    request = "GET /items/1 HTTP/1.1\r\n\r\n"
    assert %{method: "GET", path: ["items", "1"]} = Parser.parse(request)
  end

  test "parse well-formed requests with headers" do
    request = """
    GET / HTTP/1.1\r
    Location: localhost:2222\r
    \r
    """
    assert %{request_headers: [{"Location", "localhost:2222"}]} = Parser.parse(request)

    request = """
    GET / HTTP/1.1\r
    Location: localhost:2222\r
    Accept: text/html\r
    \r
    """
    assert %{request_headers: headers} = Parser.parse(request)
    assert {"Location", "localhost:2222"} in headers
    assert {"Accept", "text/html"} in headers

    request = """
    GET / HTTP/1.1\r
    Location: localhost:2222\r
    Accept: text/html\r
    \r
    {"value": 3.14}
    """
    assert %{request_headers: headers, payload: "{\"value\": 3.14}\n"} = Parser.parse(request)
    assert length(headers) == 2
  end

  test "raise on badly-formed requests" do
    request = "GET /value"
    assert_raise Parser.RequestFormatError, fn ->
      Parser.parse(request)
    end

    request = "GREET /value HTTP/1.1"
    assert_raise Parser.RequestFormatError, fn ->
      Parser.parse(request)
    end
  end

  test "parse headers and payload" do
    headers = "Location: localhost:2222\r\n\r\n"
    assert {headers, nil} = Parser.parse_headers_and_payload(headers)
    assert {"Location", "localhost:2222"} in headers

    headers = "Location: localhost:2222\r\nAccept: text/html\r\n\r\n"
    assert {headers, nil} = Parser.parse_headers_and_payload(headers)
    assert {"Location", "localhost:2222"} in headers
    assert {"Accept", "text/html"} in headers

    headers = "Location: localhost:2222\r\nAccept: text/html\r\n\r\n{\"value\": 3.14}"
    assert {headers, "{\"value\": 3.14}"} = Parser.parse_headers_and_payload(headers)
    assert length(headers) == 2
  end

end

