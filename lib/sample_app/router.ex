defmodule SampleApp.Router do
  use Felix.Router

  alias Felix.Connection

  def match("GET", ["cars"], connection) do
    SampleApp.CarController.index(connection, %{})
  end

  def match("POST", ["cars"], connection) do
    SampleApp.CarController.create(connection, %{})
  end

  def match("GET", ["brands"], connection) do
    SampleApp.BrandController.index(connection, %{})
  end

  def match("GET", ["people"], connection) do
    people = ForceApp.People.list_people
    page_contents = EEx.eval_file("lib/sample_app/templates/list_people.eex", [people: people])

    %Connection{connection |
      resp_body: page_contents,
      resp_headers: [{"content-type", "text/html"}],
      status: "200 Ok",
    }
  end

  def match("POST", ["people"], connection) do
    params =
      connection.req_body
      |> URI.decode_www_form
      |> URI.decode_query
      |> IO.inspect

    ForceApp.People.add_person(params["name"], params["location"])

    people = ForceApp.People.list_people
    page_contents = EEx.eval_file("lib/sample_app/templates/list_people.eex", [people: people])

    %Connection{connection |
      resp_body: page_contents,
      resp_headers: [{"content-type", "text/html"}],
      status: "200 Ok",
    }
  end

  def match(method, path, connection) do
    %Connection{connection |
      resp_body: "#{method} #{path} not found",
      status: "404 Not Found"
    }
  end

end

