defmodule ForceApp.PeopleController do
  alias Felix.Connection

  def index(connection, _params) do
    people = ForceApp.People.list_people
    page_contents = EEx.eval_file("lib/force_app/templates/list_people.eex", [people: people])

    %Connection{connection |
      status: "200 Ok",
      resp_body: page_contents,
      resp_headers: [{"content-type", "text/html"}],
    }
  end

  def create(connection = %{req_body: req_body}, _params) do
    params =
      connection.req_body
      |> URI.decode_www_form
      |> URI.decode_query
      |> IO.inspect

    ForceApp.People.add_person(params["name"], params["location"])

    %Connection{connection |
      status: "303 See Other",
      resp_headers: [{"location", "/people"}],
    }
  end

  def create(connection, _params) do
    %Connection{connection |
      status: "400 Bad Request",
    }
  end
end

