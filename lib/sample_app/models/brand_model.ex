defmodule SampleApp.BrandModel do
  def start do
    brands = ["Tesla", "Ford"]
    TOP.GenServer.start(__MODULE__, &handle_call/2, &handle_cast/2, brands)
  end

  def get_brands do
    TOP.GenServer.call __MODULE__, :get_brands
  end

  def handle_call(:get_brands, brands) do
    {brands, brands}
  end

  def handle_cast(_, state) do
    state
  end
end

