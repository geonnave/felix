defmodule ForceApp.PeopleController do
  alias Felix.Connection
  require EEx

  EEx.function_from_file :defp, :template_list_people, "lib/force_app/templates/list_people.eex", [:people]
  def index(connection, _params) do
    people = ForceApp.People.list_people
    page_contents = template_list_people(people)

    %Connection{connection |
      status: "200 Ok",
      resp_body: page_contents,
      resp_headers: [{"content-type", "text/html"}],
    }
  end

  EEx.function_from_file :defp, :template_show_person, "lib/force_app/templates/show_person.eex", [:person, :location]
  def show(connection, %{name: name}) do
    location = ForceApp.People.get_person(name)
    page_contents = template_show_person(name, location)

    %Connection{connection |
      status: "200 Ok",
      resp_body: page_contents,
      resp_headers: [{"content-type", "text/html"}],
    }
  end

  def create(connection, _params) do
    params =
      connection.req_body
      |> URI.decode_www_form
      |> URI.decode_query
      |> IO.inspect

    ForceApp.People.add_person(params["name"], params["location"])

    %Connection{connection |
      status: "303 See Other",
      resp_headers: [{"location", "/people/#{params["name"]}"}],
    }
  end
end
