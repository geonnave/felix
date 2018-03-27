defmodule Felix.HTTPSerializer do

  def serialize(connection) do
    """
    HTTP/1.1 #{connection[:status] || "422 Unprocessable Entity"}\r
    #{serialize_headers(connection[:headers])}\r
    #{connection[:resp_body]}
    """
  end

  def serialize_headers(nil), do: ""
  def serialize_headers(headers) do
    headers
    |> Enum.map(fn {header, value} ->
      {String.capitalize(header), value}
    end)
    |> Enum.reduce("", fn {header, value}, string_heaaders  ->
      string_heaaders <> "#{header}: #{value}\r\n"
    end)
  end

end

