defmodule SampleApp.Locations do
  use GenServer

  def start do
    locations = %{
      "jose" => "Poland",
      "joe" => "Sweden",
      "gandalf" => "Middle Earth"
    }

    GenServer.start(__MODULE__, locations, name: __MODULE__)
  end

  # API functions

  def get_location(user) do
    GenServer.call __MODULE__, {:get_location, user}
  end

  def add_location(user, location) do
    GenServer.cast __MODULE__, {:add_location, user, location}
  end

  # leave this as exercise
  #def get_locations do
  #  GenServer.call __MODULE__, :get_locations
  #end

  # callback functions

  def handle_call({:get_location, user}, _from, locations) do
    {:reply, locations[user], locations}
  end

  def handle_cast({:add_location, user, location}, locations) do
    {:noreply, Map.put(locations, user, location)}
  end

  # leave this as exercise
  #def handle_call(:get_locations, _from, locations) do
  #  {:reply, locations, locations}
  #end

end

