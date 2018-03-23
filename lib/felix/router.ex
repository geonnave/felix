defmodule Felix.Router do
  defmacro __using__(_opts) do
    quote do
      def call(context = %{method: method, path: path}) do
        match(method, path, context)
      end
    end
  end
end
