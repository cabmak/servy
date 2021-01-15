defmodule Servy.Handler do
  def handle(request) do
    # conv = parse(request)
    # conv = route(conv)
    # format_response(conv)

    # |> IO.inspect(label: "After Parse")
    # |> IO.inspect(label: "Start Here")
    # |> IO.inspect(label: "After Route")

    request
    |> parse()
    |> rewrite_path()
    |> log()
    |> route()
    |> format_response()
  end

  def rewrite_path(conv) do
    %{conv | path: "/wildthings"}
  end

  def log(conv), do: IO.inspect(conv)

  def parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %{method: method, path: path, resp_body: "", status: nil}
  end

  def route(conv) do
    route(conv, conv.method, conv.path)
  end

  def route(conv, "GET", "/wildthings") do
    %{conv | status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  def route(conv, "GET", "/bears") do
    %{conv | status: 200, resp_body: "teddy, Smokey, Paddington"}
  end

  def route(conv, "GET", "/bears/" <> id) do
    %{conv | status: 200, resp_body: "bear #{id}"}
  end

  def route(conv, _method, path) do
    %{conv | status: 404, resp_body: "No #{path} here!"}
  end

  # TODO: Use values in the map to create an HTTP response string:
  def format_response(conv) do
    """
    HTTP/1.1 #{conv.status} #{status_reason(conv.status)}
    Content-Type: text/html
    Content-length: #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """
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

request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts(response)

request = """
GET /bigfoot HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts(response)

request = """
GET /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts(response)

request = """
GET /bears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts(response)

request = """
GET /wildlife HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

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
