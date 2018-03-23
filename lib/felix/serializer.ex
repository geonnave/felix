defmodule Felix.HTTPSerializer do

  def serialize(context) do
    """
    HTTP/1.1 #{context[:status] || "422 Unprocessable Entity"}\r
    Content-type: #{context[:content_type] || "text/plain"}\r
\r
    #{context[:resp_body]}
    """
  end

end

