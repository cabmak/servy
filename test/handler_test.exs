defmodule HandlerTest do
  use ExUnit.Case

  import Servy.Handler, only: [handle: 1]

  test "GET /wildthings" do
    request = """
    GET /wildthings HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    assert response == """
           HTTP/1.1 200 Ok\r
           Content-Type: text/html\r
           Content-length: 20\r
           \r
           Bears, Lions, Tigers
           """
  end

  test "GET /bears" do
    request = """
    GET /bears HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    expected_response = """
    HTTP/1.1 200 Ok\r
    Content-Type: text/html\r
    Content-Length: 356\r
    \r
    <h1>All The Bears!</h1>

    <ul>
     <li>Brutus - Grizzy</li>
     <li>Iceman - Polar</li>
     <li>Kenai - Grizzy</li>
     <li>Paddington - Brown</li>
     <li>Roscoe - Panda</li>
     <li>Rosie - Black</li>
     <li>Scarface - Grizzy</li>
     <li>Smokey - Black</li>
     <li>Snow - Polar</li>
     <li>Teddy - Brown</li>
    </ul>
    """
    assert remove_whitespace(response ==remove_whitespace(expected response)
   end

   test "GET /bigfoot" do
    request = """
    GET /bigfoot HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept:*/*\r
    \r
    """

    response = handle(request)

    assert response =="""
    HTTP/1.1 404 Not Found\r
    Content-Type: text/html\r
    Content-Length: 17\r
    \r
    No /bigfoot here!
    """
  end



  test "GET /wildlife" do
    request = """
    GET /wildlife HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept:*/*\r
    \r
    """

    response = handle(request)

    assert response =="""
    HTTP/1.1 200 Ok\r
    Content-Type: text/html\r
    Content-Length: 20\r
    \r
    Bears, Lions, Tigers
    """
  end

  test "GET /about" do
    request = """
    GET /about HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept:*/*\r
    \r
    """

    response = handle(request)

    assert response =="""
    HTTP/1.1 200 Ok\r
    Content-Type: text/html\r
    Content-Length: 102\r
    \r
    <h1>Clark`s Wildthings Refuge</h1>

    <blockquote>
    when we contemplate the whole globe...
    </blockquote>
    """

    assert remove_whitespace(response ==remove_whitespace(expected response)
  end

  test "POST /bears" do
    request = """
    POST /bears HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept:*/*\r
    Content-Type: application/x-www-form-urlencode\r
    Content-Length: 21\r
    \r
    name=Baloo&type=Brown
    """

    response = handle(request)

    assert response =="""
    HTTP/1.1 201 created\r
    Content-Type: text/html\r
    Content-Length: 33\r
    \r
    Created a Brown bear named Baloo!
    """
  end

    defp remove_whitespace(text) do
      String.replace(text, ~r{\s}, "")
    end
end
