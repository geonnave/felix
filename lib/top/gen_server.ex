defmodule TOP.GenServer do
  def start(name, call_handler, initial_state) do

    spawn(fn -> loop(name, call_handler, initial_state) end)
    |> Process.register(name)
  end

  def call(name, query) do
    send name, {:call, self(), query}

    receive do
      {^name, reply} ->
        reply
    end
  end

  def loop(name, call_handler, state) do
    receive do
      {:call, caller, query} ->
        {reply, new_state} = call_handler.(query, state)
        send(caller, {name, reply})
        loop(name, call_handler, new_state)
    end
  end
end

