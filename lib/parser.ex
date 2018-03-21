defmodule Parser do
  defmodule RequestFormatError do
    defexception [:message]
  end

  @allowed_methods ~w(GET POST PUT DELETE OPTIONS)

  def parse(request) do
    case String.split(request, " ", parts: 3) do
      [method, path, "HTTP/1.1\r\n" <> rest] when method in @allowed_methods ->
        {headers, payload} = parse_headers_and_payload(rest)

        %{
          method: method,
          path: parse_path(path),
          request_headers: headers,
          payload: payload
        }
      _ ->
        raise RequestFormatError, message: "invalid request format: #{inspect(request)}"
    end
  end

  def parse_headers_and_payload(string_headers) do
    parse_headers(string_headers, [])
  end

  def parse_headers("\r\n", headers) do
    {headers, nil}
  end
  def parse_headers("\r\n" <> payload, headers) do
    {headers, payload}
  end
  def parse_headers(string_headers, headers) do
    [header_line, rest] = String.split(string_headers, "\r\n", parts: 2)
    [header, value] = String.split(header_line, ": ")

    parse_headers(rest, [{header, value} | headers])
  end

  def parse_path(path) do
    String.split(path, "/", trim: true)
  end

end
