defmodule Felix.Stages.RequestId do
  alias Felix.Connection

  def call(connection) do
    assigns = put_in(connection.assigns, [:request_id], :rand.uniform(1_000_000))
    %Connection{connection | assigns: assigns}
  end
end
