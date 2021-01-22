defmodule Servy.BearController do
  @moduledoc false

  def index(conv) do
    %{conv | status: 200, resp_body: "teddy, smokey, paddington"}
  end

  def show(conv, %{"id" => id}) do
    %{conv | status: 200, resp_body: "Bear #{id}"}
  end

  def create(conv, %{"name" => name, "type" => type} = _params) do
    %{conv | status: 201, resp_body: "create a #{type} bear named #{name}!"}
  end
end
