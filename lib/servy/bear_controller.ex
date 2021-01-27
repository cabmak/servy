defmodule Servy.BearController do
  @moduledoc false

  alias Servy.Bear
  alias Servy.Wildthings

  def index(conv) do
    items =
      Wildthings.list_bears()
      |> IO.inspect()
      |> Enum.filter(fn b -> Bear.is_grizzly(b) end)
      |> IO.inspect()
      |> Enum.sort(fn b1, b2 -> Bear.order_asc_by_name(b1, b2) end)
      |> IO.inspect()
      |> Enum.map(fn b -> bear_item(b) end)
      |> IO.inspect()
      |> Enum.join()

    %{conv | status: 200, resp_body: "<ul>#{items}</ul>"}
  end

  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)
    %{conv | status: 200, resp_body: "<h1>Bear #{bear.id}: #{bear.name}</h1>"}
  end

  def create(conv, %{"name" => name, "type" => type} = _params) do
    %{conv | status: 201, resp_body: "create a #{type} bear named #{name}!"}
  end

  # By convention, defp function are put at the bottom of the module
  # Note that the code will still work, but when you work with other people
  # you will find the private function at the bottom

  ## PRIVATE FUNCTION
  defp bear_item(bear) do
    "<li>#{bear.name} - #{bear.type}</li>"
  end
end
