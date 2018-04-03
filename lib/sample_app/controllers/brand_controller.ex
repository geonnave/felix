defmodule SampleApp.BrandController do
  alias Felix.Connection

  def index(connection, _params) do
    brands = SampleApp.BrandModel.get_brands

    %Connection{connection |
      resp_body: "#{inspect(brands)}",
      resp_headers: [{"content-type", "application/json"}],
      status: "200 Ok",
    }
  end
end

