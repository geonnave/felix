defmodule SampleApp.ValueController do
  alias Felix.Connection

  def show(connection, _params) do
    send SampleApp.ValueModel, {:get_value, self()}

    receive do
      value ->
        %Connection{connection |
          resp_body: "{\"value\": #{value}}",
          resp_headers: [{"content-type", "application/json"}],
          status: "200 Ok",
        }
    after 500 ->
      %Connection{connection |
        resp_body: "internal error",
        resp_headers: [{"content-type", "text/plain"}],
        status: "500 Internal Server Error",
      }
    end
  end
end

