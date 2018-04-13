defmodule ForceApp.People do
  use GenServer

  def start_link(_opts) do
    people = %{
      "Luke" => "Tatooine",
      "Han Solo" => "Corellia",
      "Leia" => "Alderaan"
    }

    GenServer.start_link(__MODULE__, people, name: __MODULE__)
  end

  # API functions

  def list_people do
    GenServer.call(__MODULE__, :list_people)
  end

  def get_person(person) do
    GenServer.call(__MODULE__, {:get_person, person})
  end

  def add_person(person, location) do
    GenServer.cast(__MODULE__, {:add_person, person, location})
  end

  # callback functions

  def init(people) do
    {:ok, people}
  end

  def handle_call(:list_people, _from, people) do
    {:reply, people, people}
  end

  def handle_call({:get_person, person}, _from, people) do
    {:reply, people[person], people}
  end

  def handle_cast({:add_person, person, location}, people) do
    {:noreply, Map.put(people, person, location)}
  end
end
