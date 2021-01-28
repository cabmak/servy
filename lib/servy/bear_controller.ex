defmodule Servy.BearController do
  @moduledoc false

  alias Servy.Bear
  alias Servy.Wildthings

  @templates_path Path.expand("../../templates", __DIR__)

  def index(conv) do
    bears =
      Wildthings.list_bears()
      |> Enum.sort(&Bear.order_asc_by_name/2)

    content =
      @templates_path
      |> Path.join("index.eex")
      |> EEx.eval_file(bears: bears)

    %{conv | status: 200, resp_body: content}
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
end
