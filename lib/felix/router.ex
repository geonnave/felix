defmodule Felix.Router do
  defmacro __using__(_opts) do
    quote do
      def call(connection = %{method: method, path: path}) do
        match(method, path, connection)
      end
    end
  end
end
