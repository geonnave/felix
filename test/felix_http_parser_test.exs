defmodule FelixHTTPParserTest do
  use ExUnit.Case
  doctest Felix

  alias Felix.{HTTPParser, Connection}

  test "parse well-formed requests" do
    request = "GET /value HTTP/1.1\r\n\r\n"
    assert %Connection{method: "GET", path_info: ["value"]} = HTTPParser.parse(request)

    request = "GET /value HTTP/1.1\r\nAccpet: application/json\r\n\r\n"
    assert %Connection{method: "GET", path_info: ["value"]} = HTTPParser.parse(request)
  end

  test "parse well-formed requests into lists" do
    request = "GET / HTTP/1.1\r\n\r\n"
    assert %Connection{method: "GET", path_info: []} = HTTPParser.parse(request)

    request = "GET //value HTTP/1.1\r\n\r\n"
    assert %Connection{method: "GET", path_info: ["value"]} = HTTPParser.parse(request)

    request = "GET /items/1 HTTP/1.1\r\n\r\n"
    assert %Connection{method: "GET", path_info: ["items", "1"]} = HTTPParser.parse(request)
  end

  test "parse well-formed requests with headers" do
    request = """
    GET / HTTP/1.1\r
    Location: localhost:2222\r
    \r
    """

    assert %Connection{req_headers: [{"Location", "localhost:2222"}]} = HTTPParser.parse(request)

    request = """
    GET / HTTP/1.1\r
    Location: localhost:2222\r
    Accept: text/html\r
    \r
    """

    assert %Connection{req_headers: headers} = HTTPParser.parse(request)
    assert {"Location", "localhost:2222"} in headers
    assert {"Accept", "text/html"} in headers

    request = """
    GET / HTTP/1.1\r
    Location: localhost:2222\r
    Accept: text/html\r
    \r
    {"value": 3.14}
    """

    assert %Connection{req_headers: headers, req_body: "{\"value\": 3.14}\n"} =
             HTTPParser.parse(request)

    assert length(headers) == 2
  end

  test "raise on badly-formed requests" do
    request = "GET /value"

    assert_raise HTTPParser.RequestFormatError, fn ->
      HTTPParser.parse(request)
    end

    request = "GREET /value HTTP/1.1"

    assert_raise HTTPParser.RequestFormatError, fn ->
      HTTPParser.parse(request)
    end
  end

  test "parse headers and body" do
    headers = "Location: localhost:2222\r\n\r\n"
    assert {headers, nil} = HTTPParser.parse_headers_and_payload(headers)
    assert {"Location", "localhost:2222"} in headers

    headers = "Location: localhost:2222\r\nAccept: text/html\r\n\r\n"
    assert {headers, nil} = HTTPParser.parse_headers_and_payload(headers)
    assert {"Location", "localhost:2222"} in headers
    assert {"Accept", "text/html"} in headers

    headers = "Location: localhost:2222\r\nAccept: text/html\r\n\r\n{\"value\": 3.14}"
    assert {headers, "{\"value\": 3.14}"} = HTTPParser.parse_headers_and_payload(headers)
    assert length(headers) == 2
  end
end
