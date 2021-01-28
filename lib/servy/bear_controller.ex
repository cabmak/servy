defmodule Servy.BearController do
  @moduledoc false

  alias Servy.Bear
  alias Servy.Wildthings

  @templates_path Path.expand("../../templates", __DIR__)

  def index(conv) do
    bears =
      Wildthings.list_bears()
      |> Enum.sort(&Bear.order_asc_by_name/2)

    render(conv, "index.eex", bears: bears)
  end

  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)

    render(conv, "show.eex", bear: bear)
  end

  def create(conv, %{"name" => name, "type" => type} = _params) do
    %{conv | status: 201, resp_body: "create a #{type} bear named #{name}!"}
  end

  # By convention, defp function are put at the bottom of the module
  # Note that the code will still work, but when you work with other people
  # you will find the private function at the bottom

  ## PRIVATE FUNCTION

  defp render(conv, template, bindings \\ []) do
    content =
      @templates_path
      |> Path.join(template)
      |> EEx.eval_file(bindings)

    %{conv | status: 200, resp_body: content}
  end
end
