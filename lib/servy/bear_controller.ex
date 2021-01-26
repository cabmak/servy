defmodule Servy.BearController do
  @moduledoc false

  alias Servy.Wildthings

  def index(conv) do
    items =
      Wildthings.list_bears()
      |> Enum.filter(fn b -> b.type == "grizzly" end)
      |> Enum.sort(fn b1, b2 -> b1.name <= b2.name end)
      |> Enum.map(fn b -> "<li>#{b.mame} - #{b.type}</li>" end)
      |> Enum.join()

    %{conv | status: 200, resp_body: "<ul><li>items</li></ul>"}
  end

  def show(conv, %{"id" => id}) do
    %{conv | status: 200, resp_body: "Bear #{id}"}
  end

  def create(conv, %{"name" => name, "type" => type} = _params) do
    %{conv | status: 201, resp_body: "create a #{type} bear named #{name}!"}
  end
end
