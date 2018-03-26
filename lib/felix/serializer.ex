defmodule Felix.HTTPSerializer do

  def serialize(context) do
    """
    HTTP/1.1 #{context[:status] || "422 Unprocessable Entity"}\r
    #{serialize_headers(context[:headers])}\r
    #{context[:resp_body]}
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

