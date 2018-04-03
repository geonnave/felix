defmodule SampleApp.BrandModel do
  def start do
    TOP.GenServer.start(__MODULE__, &handle_call/2, ["Tesla", "Ford"])
  end

  def get_brands do
    TOP.GenServer.call __MODULE__, :get_brands
  end

  def handle_call(:get_brands, state) do
    {state, state}
  end
end

