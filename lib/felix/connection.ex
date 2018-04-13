defmodule Felix.Connection do
  defstruct method: nil,
            # request fields
            path_info: [],
            req_headers: [],
            req_body: nil,

            # response fields
            resp_headers: [],
            resp_body: nil,
            status: nil,

            # other fields
            assigns: %{}
end
