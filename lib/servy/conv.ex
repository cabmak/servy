defmodule Servy.Conv do
  defstruct method: "",
            path: "",
            params: %{},
            resp_body: "",
            status: nil

  def full_status(conv) do
    "#{conv.status} #{status_reason(conv.status)}"
  end

  defp status_reason(code) do
    %{
      200 => "Ok",
      201 => "Created",
      401 => "Unhotorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"
    }[code]
  end
end
