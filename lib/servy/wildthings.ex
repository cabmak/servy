defmodule Servy.Wildthings do
  @moduledoc false

  alias Servy.Bear

  # si ya pas de parenthere, tu as pas besoin de lui donner rien comme argument, la function a pas besoin de rien pour runner..
  def list_bears do
    [
      %Bear{id: 1, name: "Teddy", type: "Brown", hibernating: true},
      %Bear{id: 2, name: "Smokey", type: "Black"},
      %Bear{id: 3, name: "Paddington", type: "Brown"},
      %Bear{id: 4, name: "Scarface", type: "Grizzly", hibernating: true},
      %Bear{id: 5, name: "Snow", type: "Polar"},
      %Bear{id: 6, name: "Brutus", type: "Grizzly"},
      %Bear{id: 7, name: "Rosie", type: "Black", hibernating: true},
      %Bear{id: 8, name: "Roscoe", type: "Panda"},
      %Bear{id: 9, name: "Iceman", type: "Polar", hibernating: true},
      %Bear{id: 10, name: "Kenai", type: "Grizzly"}
    ]
  end

  def get_bear(id) when is_integer(id) do
    Enum.find(list_bears(), fn(b) -> b.id == id end)
  end

  def get_bear(id) when is_binary(id) do
    id |> String.to_integer |> get_bear
  end

  def get_bear_by_id(id) do
    # list_bears appele la fn en haut, ensuite Enum.find() utilise le ID pour extraire le bear avec le id whatever...
    bears = list_bears()
    # Enum.find dans le containers bears, check si bear.id == id, si oui, donne moi ca...
    Enum.find(bears, fn bear -> bear.id == id end)
  end

  def get_bear_by_name(name) do
    list_bears() |> Enum.find(fn x -> x.name == name end)
  end

  # Est ce que tu vois ca? oui Good la jai plus besoin de Team Viewerok
  # ok
  # def definitition do
  #   # [] => LIST
  #   # %{} => Map, check...
  #   # {} => tuple, est utilise partout dans elixir pour , 1 min
  #   # () => utilisez dans la definition des functions get_bear_by_name(name)
  #   # "!" => negation, exemple, tous les noms qui ne sont pas "Teddy", secrit name != "Teddy"
  #   # && =>  ET
  #   # || => OU
  #   # tuple = {"rene", 1, "abc"}
  #   # add +, sub -, multiply *, divide /
  # end
end
