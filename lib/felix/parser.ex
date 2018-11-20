defmodule Felix.HTTPParser do
  alias Felix.Connection

  def parse(request) do
    [method, path, "HTTP/1.1" <> rest] = String.split(request, " ", parts: 3)
    {raw_headers, body} = separate_headers_and_body(rest)

    %Connection{
      method: method,
      path_info: parse_path(path),
      req_headers: parse_headers(raw_headers),
      req_body: body
    }
  end

  def separate_headers_and_body("\r\n\r\n") do
    {"", nil}
  end

  def separate_headers_and_body("\r\n\r\n" <> payload) do
    {"", payload}
  end

  def separate_headers_and_body(headers_and_body) do
    ["\r\n" <> raw_headers, body] = String.split(headers_and_body, "\r\n\r\n")

    {raw_headers, body}
  end

  def parse_headers(""), do: []

  def parse_headers(raw_headers) do
    case String.split(raw_headers, "\r\n", parts: 2) do
      [header_line, rest] ->
        [header, value] = String.split(header_line, ": ")
        [{header, value} | parse_headers(rest)]

      [header_line] ->
        [header, value] = String.split(header_line, ": ")
        [{header, value}]
    end
  end

  def parse_path(path) do
    String.split(path, "/", trim: true)
  end
end
