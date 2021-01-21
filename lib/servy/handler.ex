defmodule Servy.Handler do
  @moduledoc "Handlers HTTP request."

  alias Servy.Conv

  @pages_path Path.expand("../../pages", __DIR__)

  import Servy.Plugins, only: [rewrite_path: 1, log: 1, track: 1]
  import Servy.Parser, only: [parse: 1]

  @doc "Transforms the request into a response."
  def handle(request) do
    request
    |> parse()
    |> rewrite_path()
    |> log()
    |> route()
    |> track()
    |> format_response()
  end

  def route(%Conv{method: "GET", path: "/wildthings"} = conv) do
    %{conv | status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  def route(%Conv{method: "GET", path: "/bears/"} = conv) do
    %{conv | status: 200, resp_body: "Teady, Smokey, Paddington"}
  end

  # name=Baloo&type=brown
  def route(%Conv{method: "GET", path: "/bears/" <> _id} = conv) do
    params = %{"name" => "baloo", "type" => "brown"}
    %{conv | status: 201, resp_body: "Created a #{params["type"]} bear named #{params["name"]}!"}
  end

  def route(%Conv{method: "GET", path: "/about"} = conv) do
    @pages_path
    |> Path.join("about.html")
    |> File.read()
    |> handle_file(conv)
  end

  def route(%Conv{path: path} = conv) do
    %{conv | status: 404, resp_body: "No #{path} here!"}
  end

  def handle_file({:ok, content}, conv) do
    %{conv | status: 200, resp_body: content}
  end

  def handle_file({:error, :eonent}, conv) do
    %{conv | status: 404, resp_body: "File not found!"}
  end

  def handle_file({:error, reason}, conv) do
    %{conv | status: 500, resp_body: "File error: #{reason}"}
  end

  # def format_response(%Conv{} = conv) do
  #   use values in the map to create an HTTP response string:
  # end

  def format_response(%Conv{} = conv) do
    """
    HTTP/1.1 #{Conv.full_status(conv)}
    Content-Type: text/
    Content-length: #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """
  end
end

# request = """
# GET /bears HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# response = Servy.Handler.handle(request)
# IO.puts(response)

# request = """
# GET /bigfoot HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# request = """
# GET /bears/1 HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# response = Servy.Handler.handle(request)
# IO.puts(response)

# request = """
# GET /wildlife HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# response = Servy.Handler.handle(request)

# IO.puts(response)

# request = """
# GET /about HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# response = Servy.Handler.handle(request)
# IO.puts(response)

request = """
POST /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
Content-Type: application/x-www-form-urlencoded
Content-Length: 21

name=Baloo&type=Brown
"""

response = Servy.Handler.handle(request)
IO.puts(response)

# When you open a website, the server receive a request right?  When you type the name google.com, a request is send from your browser to a server listening to port 80 or 443, when the site have a ssl certificat, its 443.
# the request received, activate the server to return the page for you
# GET /wildthing HTTP/1.1 => this is a command to say, get me /wildthing page and return it in HTML 1.0 format
# Host: example.com => will be google.com for exemple...
# User-Agent: ExampleBrowser/1.1 => this line tell the server, on witch device you want to response, if you use a phone, the server can reduce the size of the image before it send the response to you, if you have a mac, the big image will be send
# Accept: */* => is use for internal network and security feature, not important for now..
# obvislouly, your browser send a more complex request to the server, but you get the idea
# The server normaly "listen" to a specific port, imagine a city, with a big wall around it, the server is the city, the wall is the router in front of it, opening specific door for specific requests
# By convention, all the browsers and IT people agreed, port 80 and 443 will be the default HTML port, so in that city, the door 80 and 443, a security guard is there to answer question for HTML requests

# watch this..
# PING google.com (172.217.13.206)
# Ping means, hello, the server respond with its IP, the number is the server...
# This server/computer, listen on 80 and 443 for html request
# This is what you are building right now... a web server
# Get it!?yep

# ["GET /wildthing HTTP/1.1", "Host: example.com","User-Agent: ExampleBrowser/1.0", "Accept: */*", "", ""]
