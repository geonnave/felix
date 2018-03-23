defmodule FelixHTTPSerializerTest do
  use ExUnit.Case
  doctest Felix

  alias Felix.HTTPSerializer

  test "build http response" do
    response = """
    HTTP/1.1 200 Ok\r
    Content-type: text/plain\r
    \r
    hola que tal
    """

    context = %{status: "200 Ok", resp_body: "hola que tal"}
    assert ^response = HTTPSerializer.serialize(context)
  end

end

